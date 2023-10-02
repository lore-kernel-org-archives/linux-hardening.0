Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91E7E3
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 06:42:24 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70829B
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 23:42:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32615eaa312so2439306f8f.2
        for <linux-hardening@vger.kernel.org>; Sun, 01 Oct 2023 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696228941; x=1696833741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFLmBMbTAf5mYpVSeF0tgLxlIm+hQtraBWqw0SVaZ1s=;
        b=naGNygrWouv1YEjdJBD+4287aMp5/GFRojK0NrGzzsdHpmff/N6Io1fiYjlkMD4aw6
         00oet6LnyjwPxQbu99r1+fu5kyqYPenaYRmQeQ6ffkTh1AE5RtYnPS9ZXtLmiUWHOhhL
         OJuaYcvCpUtBNYQn2bL2T/6pg6EP+v8C6YMM8NgTfbGPm2CH7fqmZoujoJyvNxEow2HQ
         mHoXB89mF/4n98+PCVqylfjxp/fHkkho+eANT53vHan+RFgKiy+v1kUeFJWuwjvoKvOp
         VNpdRNy01htzmY1nnH2VE7SDYyZJFveOVXtMORoIjuhv5j04wfKD9Ckx+uHxMOYL+zVg
         xsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696228941; x=1696833741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFLmBMbTAf5mYpVSeF0tgLxlIm+hQtraBWqw0SVaZ1s=;
        b=cQJLjIaeiFyt71KyoSQ3/UQ1tmp7z39Iikgc0s86B18PFsyNv6Q0BPcJPXRGagmFfR
         QUpzaWtLYVjtDZthRgX3tkGFOMdsAS2CcX67AJ9EGt15XCuctOFvww0BGUa0V1QiteBd
         9w8kvPWyDZfgaCGzwdmkgNXJ7jI7zF1Xr3M8NZTFPTB92RLY1mbY/qHGwK1qWVGNzK3f
         +8KKF8YhHMFS+ztdS4bAFqyZbFzOiA9c4HWb7OZ6cM7OxI1JUqa8ned8L4reLDEhCFTu
         7Ppa37Nz3S06Pe2WzdmZbw+JumkqgXumY4httxFqL6B6pLecf0BdHVzc2uXjWg2wNCPU
         +5FQ==
X-Gm-Message-State: AOJu0YxfTl5tNgO4lDyYiKvCAVXZcshRyEF3VfW5PvrxAz0Lzy6VwF58
	2oOWaxqlqV0G8sESzITyNXBFFQ==
X-Google-Smtp-Source: AGHT+IG5F6WCA+givsf9KFa40Uq2QQ0EtyZVPcp2/kezx1bCSCz837j2NkrcYNJnzvEwO3xWwac9nA==
X-Received: by 2002:adf:f085:0:b0:320:77f:a97c with SMTP id n5-20020adff085000000b00320077fa97cmr9346986wro.63.1696228941280;
        Sun, 01 Oct 2023 23:42:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d594b000000b003140f47224csm9346368wri.15.2023.10.01.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:42:20 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:42:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] bcachefs: Use struct_size()
Message-ID: <ff682afb-a914-4cd7-8d19-202a6cb778de@kadam.mountain>
References: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
 <7ae7737e-e32c-e9e7-880c-cafc240e7c33@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae7737e-e32c-e9e7-880c-cafc240e7c33@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 09:23:17AM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 10/1/23 09:13, Christophe JAILLET wrote:
> > Use struct_size() instead of hand writing it.
> > This is less verbose and more robust.
> > 
> > While at it, prepare for the coming implementation by GCC and Clang of the
> > __counted_by attribute. Flexible array members annotated with __counted_by
> > can have their accesses bounds-checked at run-time checking via
> > CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> > strcpy/memcpy-family functions).
> 
> I would prefer this as two separate patches.
> 

I kind of feel like it's all part of one thing.  It's easier to review
as one patch.

regards,
dan carpenter

