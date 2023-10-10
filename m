Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A05354E1
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hz1B8Pt4"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398393
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 16:19:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27cfb36c0d4so532845a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696979939; x=1697584739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9CXaUyQjGOOA7CSCB/W/++ml2XuraPjvgoqXcJSMIY=;
        b=Hz1B8Pt49r6AMAbKIeq5y+XZGI22x3nL8hVqqRyzDDX93JE/mF1RwxsBnkU7+vkzzm
         1rUagI5BXMTspnYuDzA3Tuk8ttByhuqKgJ7bQ4Pc5hYkuOubMgR7aiD0E4IvqqkSdNSy
         3wiJqKJQ7zsFCtcNnxe36UWHaoyPMG52J1a4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696979939; x=1697584739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9CXaUyQjGOOA7CSCB/W/++ml2XuraPjvgoqXcJSMIY=;
        b=N4Vnzf8uMafsATx9Xujwt8oWmban7Essrt4D7fOFKrMh+UOpOh0h/QHXrEeP+uEDbL
         4rJ8rJj3D/x8PuQMkG7R7u9iyFhQJ/So+Jm/xUwolKciAF8riS0PjvY0FSkedR4TNvWD
         WnNBpASl0ttzBY4gfQ5YX46Ys0u4kIH+3j0vWJ/u0NwapQAXswSqCikmbA0zQRVwx4lV
         j0cnL4DabBM6dpCI5vRiY2cT+5+AFxptinzgAjbzg3GmoQl2nBUEfJWoyjmP9CO7DvBB
         /bd/97CvJVlq6QESehJpS1pGOthpCvWmw5rg3rmUF4qMyunVNeRyKicEp/hNKdIZAkvm
         8UzA==
X-Gm-Message-State: AOJu0YzPIvcy9b+7VGZ+VdIrt2xLPG2Dwm0WYy6ouJ9hr5FcyC1ptRQk
	HtCf3yf4VHAXTsnuEsA95jlZwg==
X-Google-Smtp-Source: AGHT+IERQaCvxqGnsD0J15/dEMRiuUaNOhU4Jj50jBcldImnDljnv4hOyxLfnbRpqMViAlIiTToKwQ==
X-Received: by 2002:a17:90b:4f84:b0:271:addf:3c96 with SMTP id qe4-20020a17090b4f8400b00271addf3c96mr16848323pjb.46.1696979939676;
        Tue, 10 Oct 2023 16:18:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id az12-20020a17090b028c00b0026d4100e0e8sm10592453pjb.10.2023.10.10.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:18:58 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:18:56 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Subject: 2-member sized buffer structs struct_size()
Message-ID: <202310101614.AA6B7C4@keescook>
References: <ZSVKwBmxQ1amv47E@work>
 <202310101552.3578F46@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310101552.3578F46@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 03:53:28PM -0700, Kees Cook wrote:
> It's surprising how many of these 2-member structs we have in the kernel
> that do the same basic thing. :)

75. We have 75 of them:

// Options: --all-includes

@sized_byte_buffer@
identifier NAME, SIZE, ARRAY;
typedef s8, s16, s32, s64;
typedef __s8, __s16, __s32, __s64;
typedef u8, u16, u32, u64;
typedef __u8, __u16, __u32, __u64;
type SIZE_TYPE = {char, short, int, long, long long, ssize_t,
 s8, s16, s32, s64, __s8, __s16, __s32, __s64,
 unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long, size_t,
 u8, u16, u32, u64, __u8, __u16, __u32, __u64};
type BYTE_TYPE = {char, unsigned char, u8, __u8};
@@

*struct NAME {
        SIZE_TYPE SIZE;
        BYTE_TYPE ARRAY[];
 };


https://paste.ubuntu.com/p/39CyK9nyqX/

Agh

-- 
Kees Cook
