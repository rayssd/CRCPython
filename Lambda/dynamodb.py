import boto3


dynamodb = boto3.resource('dynamodb')
MyTable = dynamodb.Table('MyTable')


def readDDBItem(MyTable):
    response = MyTable.get_item(
        Key={
            'Visit': 1  # reading the value(s) of primary key ID 1
        }
    )
    return response['Item']['Counter']


def updateDDBItem(MyTable):
    response = readDDBItem(MyTable)
    value = response + 1

    MyTable.update_item(
        Key={
            'Visit': 1
        },
        ExpressionAttributeNames={
            "#gibberish": "Counter"  # has to have a # in front of variable name
        },
        ExpressionAttributeValues={
            ':anyname': value,  # has to have : in front of variable name
        },
        UpdateExpression="set #gibberish = :anyname",
    )
    return value


# print(readDDBItem(MyTable))
# updateDDBItem(MyTable)
# print(readDDBItem(MyTable)['Item']['Counter'])
