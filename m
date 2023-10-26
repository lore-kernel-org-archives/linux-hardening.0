Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441411BDC7
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mM8+zmUY"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728E1AA
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:23:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5b92b852390so791524a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698341024; x=1698945824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjCyKU5MtQNKRhUalMMT+7osPR9Bm+U2bHAZcig+q/U=;
        b=mM8+zmUYldkMLcOKwsHldyUKe7AjazhFbFZ07K3ewQVQbPnGXoMjUh48Jcdmfr7B2j
         ocTHNLiXH/QY5OcLKcHHL74dTlgaEoteMYa4u3YJ4syj/bxR8LAEQX/Ntyfhh7hminxR
         qrRvWt3myGI1Aan8NAtvTvdrde+wotpptB1x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698341024; x=1698945824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjCyKU5MtQNKRhUalMMT+7osPR9Bm+U2bHAZcig+q/U=;
        b=L8RWHh1yPjGuxzMYZpLDXY784JCG3lKHRg4ZeY23RdTphY3ycM6W8dNfqYNin6u7/M
         7w8vHO5EWTFcRZFQAc9X9/rAzwFxCtMrkwe9EWrvEE4zKd9nch31l047d/RwCj9rhg7h
         GTio6cGCYQ/x5rre/UFiu7N3AmCWamW0cbCP74SZWaJ6UncYBbbkot2eAnyw67OFb2y7
         8PGvCu9AZhvH8jDd+GUKGrdBGMwKuGJxEQSMAswoZENCotLJSrZ2dz0216u7eJwbheIV
         kS8bLjNw5YOda/bKEMHn23ovmpzHFXkIOrtbL+Oy65h8u+mUlGXVD0K4QscxSiqrhd7G
         0WDw==
X-Gm-Message-State: AOJu0Yx/eDgiCHSQ0J8mVn/Q+oNUt0xK0W3B3ppwY/4EM4l5BC26xfrJ
	DOJ/NZoOmVW4bzm3cTFYREBO6A==
X-Google-Smtp-Source: AGHT+IF7399/OM5BrcFXOLCufSQZJqJZwvqdQhkCoYNF0VGssiBtB1bI+qMz09xlR5vmh4vjcNCJBg==
X-Received: by 2002:a17:90a:db92:b0:27d:d9c2:6ee5 with SMTP id h18-20020a17090adb9200b0027dd9c26ee5mr182716pjv.9.1698341023789;
        Thu, 26 Oct 2023 10:23:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090ad98700b0027ceac90684sm1895134pjv.18.2023.10.26.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:23:43 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:23:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Justin Stitt <justinstitt@google.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] airo: replace deprecated strncpy with strscpy_pad
Message-ID: <202310261022.1B5587464E@keescook>
References: <20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com>
 <84ae63d1-671a-48b3-836b-7a12da54aa10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ae63d1-671a-48b3-836b-7a12da54aa10@quicinc.com>

On Tue, Oct 17, 2023 at 03:51:58PM -0700, Jeff Johnson wrote:
> On 10/17/2023 2:12 PM, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > `extra` is clearly supposed to be NUL-terminated which is evident by the
> > manual NUL-byte assignment as well as its immediate usage with strlen().
> > 
> > Moreover, let's NUL-pad since there is deliberate effort (48 instances)
> > made elsewhere to zero-out buffers in these getters and setters:
> > 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
> > 6130 | memset(local->config.rates, 0, 8);
> > 6139 | memset(local->config.rates, 0, 8);
> > 6414 | memset(key.key, 0, MAX_KEY_SIZE);
> > 6497 | memset(extra, 0, 16);
> > (to be clear, strncpy also NUL-padded -- we are matching that behavior)
> > 
> > Considering the above, a suitable replacement is `strscpy_pad` due to
> > the fact that it guarantees both NUL-termination and NUL-padding on the
> > destination buffer.
> > 
> > Technically, we can now copy one less byte into `extra` as we cannot
> > determine the sizeof `extra` at compile time and the hard-coded value of
> > 16 means that strscpy_pad() will automatically truncate and set the byte
> > at offset 15 to NUL. However, the current code manually sets a
> > NUL-byte at offset 16. If this is an issue, the solution is to change
> > the hard-coded magic number to 17 instead of 16. I didn't do this in
> > this patch because a hard-coded 17 seems bad (even more so than 16).
> 
> this function is a wext handler. In wext-core.c we have:
> static const struct iw_ioctl_description standard_ioctl[] = {
> ...
> 	[IW_IOCTL_IDX(SIOCGIWNICKN)] = {
> 		.header_type	= IW_HEADER_TYPE_POINT,
> 		.token_size	= 1,
> 		.max_tokens	= IW_ESSID_MAX_SIZE,
> 	},
> 
> So the buffer size is (strangely) IW_ESSID_MAX_SIZE if you want to use that
> for the buffer size

Yeah, that seems like a good refactor to do at the same time.

> > -	strncpy(extra, local->config.nodeName, 16);
> > -	extra[16] = '\0';
> > +	strscpy_pad(extra, local->config.nodeName, 16);

Justin, can you respin this with the open-coded "16" updated?

-Kees

-- 
Kees Cook
