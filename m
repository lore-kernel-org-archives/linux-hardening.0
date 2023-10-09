Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208438DFC
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PoZiT3Uq"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A11AEB
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:01:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692eed30152so3553032b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696878087; x=1697482887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IFH55pRhzV5onmAR0V0RcmvgjZQ6iKkHWC3kCd8jJc=;
        b=PoZiT3UqKgc5P5UHtpnVW9w2t38Nr2lIz8qnfzc1ZvUOpn45tx9nUbDt5j/yVMw2PK
         FZWWhuqP/AyRzKTPaR2BTsHcc7vWWTFf0f056NVcoZu6Oen/oTltyHLInlmAKa5i22Pf
         Lb+/Vt4+SqT9yzQjVVTIxBdVOnOQTO5Tp5XtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696878087; x=1697482887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IFH55pRhzV5onmAR0V0RcmvgjZQ6iKkHWC3kCd8jJc=;
        b=v3PH5dEoZJjhWWCyVoame2tBUF7e5mO4KD64aYfaZy5y9EfOoMta+NPGKiEXOttg/7
         ftjqkRtTbjFbKnWhsryn9t7j1Nbz817VqHGN45EEstwZu5hWdT+ZoiKVOtoJMpfgvbBa
         NdcmRjCnzO0hm/gOwRiT6K1eZoIxko0Eke4MdBwAjX4Qc4zJ4OUdnBzTPIukX9+sSkWb
         kuX2Tnzwv9reFrhdwyq886rO1LtwcssspRowz3iXIZBZAcPNV/uk7k8+xRw0a3xm0Tji
         C0d5pTD9jig2giMqPK/DXjEh9tMpdp+Z5FoTY0jRuSCVmwkektub4W3pdMpba4E/Dmvr
         Ianw==
X-Gm-Message-State: AOJu0YwkEbI/zYs/A2kpWvBNmC4UfA4geeDwwAtibA2Pw4yk6CNfdfiQ
	pBdEL8UiLrq6+SGbcGuEHhUjDA==
X-Google-Smtp-Source: AGHT+IEdiLUEPaXGkHEsA/tYV+jvxhXR25Tgergrl7cSdjdxq9CSr6ZJuinl4dMflGBaKnVK+mZmDw==
X-Received: by 2002:a05:6a00:b82:b0:68f:e810:e894 with SMTP id g2-20020a056a000b8200b0068fe810e894mr17362981pfj.33.1696878085896;
        Mon, 09 Oct 2023 12:01:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f24-20020aa78b18000000b0068fd026b496sm6613220pfd.46.2023.10.09.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:01:25 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:01:23 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen/xenbus: Add __counted_by for struct
 read_buffer and use struct_size()
Message-ID: <202310091200.2DFF1FE4B5@keescook>
References: <ZSRMosLuJJS5Y/io@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRMosLuJJS5Y/io@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:55:30PM -0600, Gustavo A. R. Silva wrote:
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

Looks good. There are going to be lots of 1-byte flex array members...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
