Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FB7993B
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641122; cv=none; b=cydHrqMKAbUU08U+onS3PNc+UFZ+AlRWzg1jCog6aWvkZ55CqfgPtF3f83/gqYU6PIp5LQVhmVZKLFo9A3KpV+9+QsKrTy5cFxq8NCXwLIdaG1GhZTdl6kJ3hQQORD1O79ZSoU1+aywmCRb1BjXz6RBo8JtdGlUD+WcH6VJq6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641122; c=relaxed/simple;
	bh=feOlOVjVoDFlYhJijI29hyyTBq3VHkJbnIkbQHkWo+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOIOpdav2sWj0GSXYVFZ5pkx7608QHEGirS3+Hfv00p830jk2jHZGbDA9bhU+5G03xAjl0egP1eIFKFuXsJZTX+PrSN9mkxipMEyuC2NTuGZj7Ft/6I4sh70Tnda5Lh8acG+aPE7B49K5jt9oHDJaaWFyxmbnXsD+tIAWUNQWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c41c070efso886016d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 10:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641120; x=1707245920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQQdl1Z7hWzrJNQVbHBRvsLI1/jbn0qd6qXGr4XoIGk=;
        b=b+x6MIiLPLoEtODIWxuUK2nnL70HBXqsSGP1nxL46oNm0irmzSUBVOQbs/YkGSsitv
         8YKGPp0sjTv+hTm65JIMlRoivd84SVN39YNcqUl9K08iKXFNZfHuG4um2YKp/0swCbPI
         DYaD2do5CvMcBGT46AXWcRVmesTYr5K/l+MJfKebtGIPMqBherp/ZeJPPNvAbJ5Y8WKx
         5PDnYlNJwTxVpl49EJW5y2U3VQro/6ajTJCISxtdCwPZwadLyk0Hw3sF7gYyIgJZzgNP
         GEdTPJF0l/NEQEn68FeDAe3izCKQQX8mlbhccl9ScoNFyP2ctJ3E8uQlvvCOv9sGWIDj
         t39w==
X-Gm-Message-State: AOJu0YxDk/UVyudoSlWxye9W+1vs2I1NwWo/YeCQNNywB0n+DZvEni3V
	RFX18w2utuAvkM+a7UUjuPE8XPnvpYSTnRWfpVdHciBy3/FTCOiekB3cJpmApw==
X-Google-Smtp-Source: AGHT+IFAvIv3XblWdgdQ8RQaDq6JHCKiCsKus1Crsy6Zo4z9JO1wUINYuy/SufWB3UTtR+pOQa194Q==
X-Received: by 2002:ad4:4353:0:b0:68c:4b59:d4ee with SMTP id q19-20020ad44353000000b0068c4b59d4eemr1868859qvs.21.1706641120069;
        Tue, 30 Jan 2024 10:58:40 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id or32-20020a05621446a000b0068189e9d3a3sm4322738qvb.112.2024.01.30.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:58:39 -0800 (PST)
Date: Tue, 30 Jan 2024 13:58:38 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 47/82] dm verity: Refactor intentional wrap-around test
Message-ID: <ZblG3sBtxv68aRyH@redhat.com>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-47-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-47-keescook@chromium.org>

On Mon, Jan 22 2024 at  7:27P -0500,
Kees Cook <keescook@chromium.org> wrote:

> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: dm-devel@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Please change subject to:
"dm: Refactor intentional wrap-around test in a few targets"

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
