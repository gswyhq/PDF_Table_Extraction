#!/usr/bin/python3
# coding: utf-8

import sys
import os
import camelot

def pdf_to_csv(pdf_file, mode='csv'):
    if os.path.isfile(pdf_file):
        pass
    else:
        pdf_file = os.path.join('/tmp', pdf_file)
        assert pdf_file, 'PDF文件不存在'
        
    old_pdf_file = pdf_file
    pdf_file = pdf_file.lower()
    
    if pdf_file.endswith('.pdf'):
        tables = camelot.read_pdf(old_pdf_file)
        csv_file = pdf_file[:-3] + mode
        zip_file = pdf_file[:-3] + 'zip'
        tables.export(csv_file, f='csv', compress=True)  # json, excel, html
        print('文件保存在： {}'.format(zip_file))

def main():
    if len(sys.argv) >= 1:
        pdf_file = sys.argv[1]
        if len(sys.argv) == 3:
            mode = sys.argv[2]
        else:
            mode = 'csv'
        pdf_to_csv(pdf_file, mode)
    else:
        for pdf_file in os.listdir('/tmp'):
            pdf_to_csv(pdf_file)


if __name__ == '__main__':
    main()