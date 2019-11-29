'''
Name: Andrew Abbott
Assignment: HW 9
'''
import mysql.connector
import config
import sys

def print_choices():
    print ('1. List countries')
    print ('2. Add country')
    print ('3. Find countries based on gdp and inflation')
    print ("4. Update country's gdp and inflation")
    print ('5. Exit')
    print ('Enter your choice (1-5):')
    user_choice = int(input())
    return user_choice

def list_country(con):
    print
    rs = con.cursor()
    #create and execute query
    query = 'SELECT  country_name, country_code from Country'
    rs.execute(query)
    #print the result
    for (cname, cid) in rs:
        print (cname + ' (' + cid + ')')
    rs.close()
    print

def add_country(con):
    temp_countries = []
    #get inputs
    country_code = raw_input('Country code................: ')
    country_name = raw_input('Country name................: ')
    country_gdp = int(input('Country per capita gdp (USD): '))
    country_inflation = int(input('Country inflation (pct).....: '))
    print
    #query to see if the country is already in the DB
    rs = con.cursor()
    query = 'SELECT country_code FROM Country'
    rs.execute(query)
    #clean the result set
    for code in rs:
        temp_countries.append(code[0])
    #check to see if the input is already in the databse
    if country_code in temp_countries:
        print(country_code + ' already exists in the database!\n')
        rs.close()
    else:
        #insert into the DB if new
        query = 'INSERT INTO Country (country_code, country_name, gdp, inflation) VALUES (%s, %s, %s, %s)'
        vals = (country_code,country_name,country_gdp, country_inflation)
        rs.execute(query, vals)
        con.commit()
        rs.close()
        print('Entry placed into the database')
    print

def find_gdp_inflation(con):
    #get inputs
    num_countries = int(input('Number of countries to display: '))
    min_gdp = int(input('Minimum per capita gdp (USD)..: '))
    max_inflation = int(input('Maximum inflation (pct).......: '))

    rs = con.cursor()
    #make the query
    query = '''SELECT country_name, country_code, gdp, inflation
                FROM Country 
                WHERE gdp >= %s AND inflation <= %s
                ORDER BY gdp DESC, inflation ASC
                LIMIT %s'''
    rs.execute(query, (min_gdp, max_inflation, num_countries))
    #print the result set
    print
    for country, ccode, cgdp, cinf in rs:
        if country is not '':
            print(country + ' (' + ccode + '), ' + str(cgdp) + ', ' + str(cinf))
    rs.close()
    print

def update_gdp_inflation(con):
    temp_countries = []
    #get inputs
    country_code =raw_input('Country code................: ')
    country_gdp = int(input('Country per capita gdp (USD): '))
    country_inflation = int(input('Country inflation (pct).....: '))
    
    rs = con.cursor()
    query = 'SELECT country_code FROM Country'
    rs.execute(query)
    #clean the result set
    for code in rs:
        temp_countries.append(code[0])
    
    #check to see if the input is already in the databse
    if country_code in temp_countries:
       update = 'UPDATE Country SET gdp = %s and inflation = %s WHERE country_code = %s'
       rs.execute(update,(country_gdp,country_inflation,country_code))
       con.commit()
       print
       print('Country updated...')
    else:
        #notify if the country doesnt exist in the DB
        print
        print('The country entered does not exist')
    print
    
def main():
    try: 
        # connection info
        usr = config.mysql['user']
        pwd = config.mysql['password']
        hst = config.mysql['host']
        dab = 'aabbott_DB'
        # create a connection
        con = mysql.connector.connect(user=usr,password=pwd, host=hst,
                                      database=dab)

        while True:
            user_choice =  print_choices()
            if user_choice == 1:
                list_country(con)
            if user_choice == 2:
                add_country(con)
            if user_choice == 3:
                find_gdp_inflation(con)
            if user_choice == 4:
                update_gdp_inflation(con)
            if user_choice == 5:
                break
        con.close()
    except mysql.connector.Error as err:
        print (err)

if __name__ == '__main__':
    main()
    
