Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB22374C
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137704; cv=none; b=Jv1XeJSZU1H71VSBqWHGq+6CKjw0ggWT3uqlBeuWnlEgQfVEtY6YEkTtTnxRvad26cV2nxfkx+yezG92lOagO/ncM0y8LghEgzxRMuUqynk6ZxdDrsCWQ6iQnDEION0iNV6n+5yppt6p35SqyPc+hVAodEb9z1H0uvHMIagOwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137704; c=relaxed/simple;
	bh=NtkIUt/NPExzmQ+Wgm/bq1k0NjISHJOHOb1px1CosPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlqOs7v9PrlhvC+WsmoQ7KC/TEZ8S/8GsykkdmGBglVFL+i3DXNS4hq5Hb8wmCayXXiMueUn0abQaqsr39KEdPlXolHghSS8G056lVbtp8XAQrykfCuf+B9rFt2XRLNDCvyM3VnKL49lPYoUukPN2GBqKLXzofkGWtVb1G1n/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bB0+0/ky; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bB0+0/ky"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d74045c463so33631235ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 04:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707137703; x=1707742503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eqj6VUl3ElBcX9JFZIdAfEkD+ItQaBMHqyrnfhAesA=;
        b=bB0+0/ky4JHuXyGYYSy5vXUmfaB7bItK39IhrUORN9M5UPfLNJSZe8fWe6yPOe+9tN
         unDKDfDSKmUMBERlzsHNrDrrWvOQ5X5kIoF4LswI9BEKWio5YyZbGlsHjnJyXpsc20g1
         ouDfzYSGFbxV1GvH4Fu9s3ewzMXQNHxrHXHgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137703; x=1707742503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eqj6VUl3ElBcX9JFZIdAfEkD+ItQaBMHqyrnfhAesA=;
        b=KGAIr6WsHF0kJF7iJFySIjnC0GWcXjICRPhpCHFxgByE1VyWdLsWZMbPyk7T4PiBL9
         LA4Iz9wZ8k5lWFtteHF/HzP45CvXtDdeppTQTCOQ8nB8eQnNNrw0du8vn/XTPYDEvZco
         3QRzixi/uN3ExQXsvtRetufp4W7JsJ/tFGnnvHKT3R4XIo0MtJ1BOJNgfAshHfSxlvFt
         i/DsJDsr+vGzjBilUqT6387mpCGA1fmYnYM8veaDytSwc06xzDCq8LrAHgtYTDT5Ons4
         5yEfUQLGVsBpIYVFEVu/EhdEuDAugDRzMuEyXK3TXZXP+2nk9VINatYr9Y8FgyRpj8ke
         h4Aw==
X-Gm-Message-State: AOJu0Yyj433wWHtqdfLq32eBw4QfYp8bn9nDgRlEPNyx5l2t5IbYtxlO
	Ib3Y8wY3IY0aPiVWlb1WkzzwaR0WOFLdupOGyHFnR19lVFKGwxGMavu8Dn7lsg==
X-Google-Smtp-Source: AGHT+IHyEglIjeQqir7zX7bqgdlVQTPfRLYGhj2TDOlxCrJpuSazsofGogVJ+1ntp+fMcQJK4wHRDA==
X-Received: by 2002:a17:903:5c8:b0:1d9:119e:af45 with SMTP id kf8-20020a17090305c800b001d9119eaf45mr7936692plb.41.1707137702940;
        Mon, 05 Feb 2024 04:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvdRXb6IOojIEym9pwkxXlecm3xXPYtnEqiRGrRaTf3kIs2Z5KJraNbE/dJM891G3HSSeoAyl6cHepw9FKKFNe6zWRkBmJaPg4EPsrA297HHgCLk422SqAzhzcLyci1XD1IVJCDaf7u90yPFwGNklRZ9Xzkhxdf5euNB5RlG3QMNih/A==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903008b00b001d94c01ae96sm6284354pld.66.2024.02.05.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:55:02 -0800 (PST)
Date: Mon, 5 Feb 2024 04:55:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
Message-ID: <202402050454.AD5C144E@keescook>
References: <20240130234634.work.003-kees@kernel.org>
 <202402020154.0266109CBF@keescook>
 <95711933-415e-4a49-a55b-8477a990a0e7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95711933-415e-4a49-a55b-8477a990a0e7@gmail.com>

On Mon, Feb 05, 2024 at 01:54:08PM +0100, Andrey Ryabinin wrote:
> 
> 
> On 2/2/24 10:55, Kees Cook wrote:
> > On Tue, Jan 30, 2024 at 03:46:38PM -0800, Kees Cook wrote:
> >> The kernel hardening efforts have continued to depend more and more
> >> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
> >>
> >> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> >
> > I don't see Andrey on lkml in almost a year, so I'll drop the entry for
> > now. Andrey, if you want to be added, just say the word! :)
> 
> I occasionally read that stuff, so I'd appreciate if you'd kept me in ;)

You got it! :) I appreciate having more eyes on it. I'll add you back.

-- 
Kees Cook
