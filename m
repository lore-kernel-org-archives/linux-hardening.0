Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B87351B
	for <linux-hardening@vger.kernel.org>; Thu, 14 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433673; cv=none; b=ZowsN1shIYOoExAKpHrX6eSNeRKf1DuucNfZt3qhrmdcoU/cmbvrfbYC950AHfP1+I++/WwmsaTVhg1k2zajQDtkE5KKav+V4StkYgzulQXI1AjL0RyGjPIiMfGWlukMaD4A/ch3phpOzL52FOmYbVwCYhp8KFHlFEf8GPp/Y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433673; c=relaxed/simple;
	bh=YdPCr4InfP4OG9EGwglXBYsVX4V6BqWttPeipUoQlMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2bdeAsvNt1a8Js+vjziKQiw9WPLPWq74G7MQlSGYotolH8bHkk+bLUSeeL9KGgw/AWj5a7i8PhvBTyCQrL8/EHZO6jp+G789IyzX4qd0jVF20vMz9dF8GnkmvHDGVRQbWU+Xv7TA4TF6jQB6kw181ne8UDU+2YSrpOC3jK5/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fDhOua8E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDhOua8E"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dde2c0f769so6768555ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Mar 2024 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710433671; x=1711038471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCqqyqrVd1ZT9AtcPC9C9BzKjRf2o6CGP4oxyF2PKO0=;
        b=fDhOua8Eu+PW0yD3MV/CXyR5+OISMCiN68d1b3VNgrGTJ/EBLqmgmPUxUcp0mPucZB
         mK8cfuBuH52L2LxgVQw/9l3LIl9uwBrmwblJcZN88NKRAdu5jNXJDiHqQRaCXS4nPA9B
         lM+54Nct4E+snumZJEjw65k/zzN36bZyp2GW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710433671; x=1711038471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCqqyqrVd1ZT9AtcPC9C9BzKjRf2o6CGP4oxyF2PKO0=;
        b=FH5oQKr0LQ2qf+OtYbv2iyPMdFkRGpCR9+aKRHvbB+T2Io0i+ZeiAoB4ic8e5A50IF
         OyL8LQgf+o1tHoquguEQUL7EEKhMYpvrqavYIJVFNPA8cARyQLSzSc6PeD7yAmwhwOj0
         BoU1VYmS+tBeW5C39qSfb2AVYm6BK2X16xxPlQaGpLyyBtcE5lUMy2C7kKflGK37ZFCe
         HiG2PeOzuVdpUqphd9q0pMW836RMF+jrqeWffeJxjP2+gH4ce1d00vNp1twZmun+1Ob3
         B73DBYHp3c6QZlOUmXWUgIs+GMTcoxluMO09ktaNq83AEzjDvi2V9CAOjL8CavJpIF9k
         d+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN8lsDFZV7/6t2acYtakR/dxaxyqNCRMQHYSXVXM5/k6gUjB0lSvoiyPRFRdG4V3Z9+PUyg04FY27a5nHsWUGKvWjj4uRVLVzuWH1ZZLfw
X-Gm-Message-State: AOJu0YyLe0lgudovLm0nR7OxGz4fU33jxpUAHMozSw13F7Z/cn5CazkX
	S/fIy89XELbxChwTT3hL2GqTLxj4GROaCPIOSaGdgVXbBEezrgZxaNyAw1iSeQ==
X-Google-Smtp-Source: AGHT+IGB+4KsUsZtAt2GEhKCBD82Z12NV2ggL3N9c8FAaT23sfhQfhvx2qsrcS+ssYSXM7KAVvrcSw==
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1835572pls.39.1710433671438;
        Thu, 14 Mar 2024 09:27:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b001dbae7b85b1sm1893090plg.237.2024.03.14.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:27:50 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:27:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
	x86@kernel.org, akpm@linux-foundation.org, shakeelb@google.com,
	vbabka@suse.cz, rppt@kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	ardb@google.com
Subject: Re: [RFC PATCH v2 00/19] PKS write protected page tables
Message-ID: <202403140927.5A5F290@keescook>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>

On Mon, Aug 30, 2021 at 04:59:08PM -0700, Rick Edgecombe wrote:
> This is a second RFC for the PKS write protected tables concept. I'm sharing to
> show the progress to interested people. I'd also appreciate any comments,
> especially on the direct map page table protection solution (patch 17).

*thread necromancy*

Hi,

Where does this series stand? I don't think it ever got merged?

-Kees

-- 
Kees Cook
