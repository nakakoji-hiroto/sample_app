class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModeloオブジェクトを生成する
    @list = List.new
  end
  
  def create
    # データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    if @list.save #データをデータベースに保存するためのsaveメソッド実行
      # 対象のカラムにデータが入力されていればsaveメソッドでtrueが返される。
      redirect_to list_path(@list.id) #詳細画面へリダイレクト
    else
      #対象のカラムにデータが入力されていなければ、saveメソッドでfalseが返される。
      #新規投稿ページを再表示する。
      render :new
    end
  end
  
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end
  
  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
  
end
