Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7642A96
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593856; cv=none; b=nF8YLFQua4gZRE7RzMYVUr5wFnLC5rbkDVsIGrmvSqnAJgQlhr3PJi11M/CM3KBxdYU9EnO5Op8QHxeeyZ6AKtjWYYfVff+skCtHxb4wjTyEYifji2xBE3RqHsJpAmpwXSVdl8nUyhQsSZuhgRFsGKHxGta4Ap8d50W9rhCcGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593856; c=relaxed/simple;
	bh=goFmT9k+2JBPJZfg9ckRb9nR9k6bSBMAukkNNw6B6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTkI5LK0Vs4mWXNPoO6h5aZT25rVWL8K7cgDrirNyp6FMY0fUZ+sWLDJZG8MDV6UP1Q0HIPxbHlm8GNDpMY44ruXVD1xqOqxnp/zKPF/MP+97wW2Cefk0mxs2IFMVX+w0XwEjDpamDdQU3J46OLnUXxCSKyf+HnHEvw1RQSpaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Dst0cKx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Dst0cKx"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7dea2de1301so309316639f.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714593854; x=1715198654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=la4DlPMR/LfwCzRSAUSsTV1pUfLPTBPpS3kAQ67eY88=;
        b=0Dst0cKxRAN94eQXZsEOLg8krWQz3TQsYZ1f/u6n9FX72Kl/C+L5A1/y9GDu1SZLPl
         rKD25k7N7AU6YwQjJjyKazefqadIwmW5C8dRG1j/oh2ner+lT4EuO6bJVZRYkp49Wutv
         9WrAflyCslzVnf7Pmhp28ohqVmshCfKWPT36Y4Impy2XrgNlDh9ILVhyCk9mdw+ptrc/
         CwGsgTYPE43vgaaebaRzpzWda+p8i38QafhBEvqbmqt0lqZq6+7K3pMSYSNrhaMstgSw
         VDhmt91s9FmZZ7pjKEokcAo5YToLqKC1rfGJ6Rd6/123ROZOD8luy9TfeCYHIcmEwnEW
         RB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593854; x=1715198654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la4DlPMR/LfwCzRSAUSsTV1pUfLPTBPpS3kAQ67eY88=;
        b=HvR9LuKB2tOv7RRwj70ECiD1zWa8Lzrvj2AiWY2eFZVVXcjHDgIgbEa5jiiqrqur62
         eRezKmiJlxNEQPtF/lBJd9QgQa3LcrGrbhXKJfEU4O9WfWoHk/UIMFVIFqgEycYFYcud
         kmi8UjWQJfFhRyIOBoT5bwq3Dw2PDwIB/v0hvvR2si9WaRzfyoyX4xdnh2VkQoNGdLjn
         aI85gV3T4Q4vYR6/gQNg4lTC4+J7bQTKS2vWqowk5YPBnLf5HPtcE9SNX1EzQbtzQYxm
         W5o+N6JO30qNBGaz1WrHz3L5dNslr9FxZovJmzdu1Y3M8T3omCmedMUyMbBnt4hnlFm6
         LJXg==
X-Forwarded-Encrypted: i=1; AJvYcCWsazWLdU2WKaNjlFWlHQa3msPmBe8XwX/k7PckNjCaq+Ovp3eIMz4UklEV7XRyE5dql6CAkVOfy9var4DK5FcWmaoPPa9BWqdieBqRl1NO
X-Gm-Message-State: AOJu0YzS79FIt3NXYhvE6v49YsSBuOZrcgGBqCw7nJSrEr75M/a5cxqb
	v/FlnKjIPk9KY319cSyoxQJXN9+0nMnqI0+I+oOyHhSfT1RtRMtCIPW1a5AqJA==
X-Google-Smtp-Source: AGHT+IEEEQZDWGpMnb8dlVbqbwAhZplRKDs07yBgDxjFH/4t0U8l/v9WICZttfLVrjYYi7DRpJYwqQ==
X-Received: by 2002:a5e:c80c:0:b0:7de:ca48:4fab with SMTP id y12-20020a5ec80c000000b007deca484fabmr4120481iol.2.1714593854425;
        Wed, 01 May 2024 13:04:14 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id f3-20020a056638168300b00487bf7fcf5csm1925536jat.179.2024.05.01.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:04:13 -0700 (PDT)
Date: Wed, 1 May 2024 20:04:11 +0000
From: Justin Stitt <justinstitt@google.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Message-ID: <jtcun2xb3ekurqekt4ckgvu2a2hgqyidkno5a5wwy4br54cqdo@riyxzf3kxtn6>
References: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

Hi,

On Wed, May 01, 2024 at 07:01:22PM +0200, Erick Archer wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>  include/uapi/linux/sctp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> index b7d91d4cf0db..836173e73401 100644
> --- a/include/uapi/linux/sctp.h
> +++ b/include/uapi/linux/sctp.h
> @@ -1007,7 +1007,7 @@ enum sctp_sstat_state {
>   */
>  struct sctp_assoc_ids {
>  	__u32		gaids_number_of_ids;
> -	sctp_assoc_t	gaids_assoc_id[];
> +	sctp_assoc_t	gaids_assoc_id[] __counted_by(gaids_number_of_ids);

Crucially, gaids_number_of_ids is assigned before any accesses to
gaids_assoc_id[] are made.

|	ids->gaids_number_of_ids = num;
|	num = 0;
|	list_for_each_entry(asoc, &(sp->ep->asocs), asocs) {
|		ids->gaids_assoc_id[num++] = asoc->assoc_id;
|	}

So this looks good to me.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  };
>  
>  /*
> -- 
> 2.25.1
> 

Thanks
Justin
