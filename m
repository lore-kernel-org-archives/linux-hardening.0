Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95737328D2
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq+dK+u9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C1C433C8;
	Mon, 16 Oct 2023 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697482565;
	bh=QcyXCskRPbOnWPMhi0EFFGjPvt4mFSLqbM7WXj8RRTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uq+dK+u9sQe6i12LxkLFZefC/LT+F/9isgSSyVWofETmERrXFkhy+LsslGY1SPxQV
	 aNRQG0xZYpZ5jC6v9GY7QL8u18a2CRGqIQeCyx/x5cfK82FJAT/K4vFTT6ykOqVrHj
	 BTmOtqrkGGTIw/ICGxhPbbQEM0fD7lZJ1BBaGjpsN1bCnC5HQq6DbRLUtRo1ZYux0I
	 ZFSJ69pSRxIexDVunyOx81Qn45YSlFJ25gPmSVu2bpvMCU7WOoKBI4Uv1sqWVE0zIL
	 oicyw/lhvaWlRK9akRu/yLwe5GlYv1URMtVBfGARefOiL3KaPRvTHfWfUqsOBfK4bb
	 JKL4Bgp1crJmg==
Date: Mon, 16 Oct 2023 11:59:52 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] soc: qcom: apr: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <arc5clw7z2avnt2tbw5mw6lvrj3kjebmuarju4uqc2hxtuv7ow@htiko7yh3oyf>
References: <ZSRw6RNi3Crhd32H@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRw6RNi3Crhd32H@work>

On Mon, Oct 09, 2023 at 03:30:17PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thanks.

> ---
>  drivers/soc/qcom/apr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 30f81d6d9d9d..1f8b315576a4 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -41,7 +41,7 @@ struct packet_router {
>  struct apr_rx_buf {
>  	struct list_head node;
>  	int len;
> -	uint8_t buf[];
> +	uint8_t buf[] __counted_by(len);
>  };
>  
>  /**
> @@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>  		return -EINVAL;
>  	}
>  
> -	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
> +	abuf = kzalloc(struct_size(abuf, buf, len), GFP_ATOMIC);
>  	if (!abuf)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
