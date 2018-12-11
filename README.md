
# 构建镜像：

`docker build -t pdf_table_extraction:20181210 --no-cache -f Dockerfile .`

# pdf to csv

`docker run --rm -it -v $PWD:/tmp pdf_table_extraction:20181210 ./docker-entrypoint.sh table.pdf`

# 参考：
[从PDF文档抽取表格数据](https://github.com/socialcopsdev/camelot)

