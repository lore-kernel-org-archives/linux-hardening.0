Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768C3B7A6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e49YNKPB"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63845B6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:55:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af86819ba9so3275465b6e.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881325; x=1697486125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2oeqp3vsnzol12qJsH7t5pwzT22fcVGWFcsZw9gAeQ=;
        b=e49YNKPBTliwNjSusO5UiRS+VYYjYXrUW2AXOITzwEco2pszVSyER/KO8YosmwDv9r
         HI0/oYcD7Y0ynb9mvuitHkTygvDNMo7KwZaoHEI4xMj11jtV0gRzy6t4vCDiE4OSAtTl
         kohBKnEGjK1gubN1wZRmQzNTLTmneBclB/eiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881325; x=1697486125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2oeqp3vsnzol12qJsH7t5pwzT22fcVGWFcsZw9gAeQ=;
        b=QK1iBwk+rKpZ2DXIPe9pEQJw1dUKUkyk+ws/aakZ0He6xwcLfUd7nFyXkWihq/oYi4
         j+7aa7XJd+AMj7mn2eeaeOrpr5wFWIluejlATxqq1tAyNceGbZb4G+bgEoTQpXAoQYS2
         0oIrr53Ek4UD6ya7EZfgTvO0FTyjSjeyUnsdI7UDG4+cCYM9hyVXxgtTnuKLrvB19vpQ
         6b8XWLyT8SYlOy3/klGRPtKsWPaVauwEjCSd0fmhFrSXbwp8Mrv4bySepS2+Z2vVFPBu
         GDnyzuaMRTECo1OzZ0YxFD2fpiEmjGt9F7dbAVlSv4AFxLKYMvFHYhamPd0az/E5iZPx
         Ca5w==
X-Gm-Message-State: AOJu0YzSmztZeJuT4VKx6L+2waIyKAG3U8qf9l7YE+ltFZx59wrfN5KF
	tZxfwdWmUZzmMslRcNrPKaTDnw==
X-Google-Smtp-Source: AGHT+IEW76hnyqWQm6dx7fkMLUIKFeLwSaHCknksL2Hnb9vUu2oxmEXFeoHcxu/AMNmN+0P35McgIA==
X-Received: by 2002:a05:6808:191:b0:3a7:3ea1:b5a0 with SMTP id w17-20020a056808019100b003a73ea1b5a0mr17704065oic.47.1696881325710;
        Mon, 09 Oct 2023 12:55:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a639552000000b005501b24b1c9sm8733176pgn.62.2023.10.09.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:55:25 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:55:24 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ima: Add __counted_by for struct modsig and use
 struct_size()
Message-ID: <202310091255.FCA0DB3C1@keescook>
References: <ZSRaDcJNARUUWUwS@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRaDcJNARUUWUwS@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 01:52:45PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
> annotation has effect, and flex-array member `raw_pkcs7` can be properly
> bounds-checked at run-time.
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right; good catch on moving the assignment.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
