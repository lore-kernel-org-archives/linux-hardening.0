Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824113FD9C
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420227; cv=none; b=E3xzlBojXEPn3GEkGoyerEP9CnZ5R9keTxSZthTQA3//VCW0dhoHZM3O1leREStJqscGeFaQrcuv8UZ+lAA9UMzWaRGOEQifdfYMpP07c2gOQVqA3Nygd21GWEayhsekDLj1tko7HBlJtKiWVr4f7QzaTv8I+Nbg3dMBbkk8E8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420227; c=relaxed/simple;
	bh=eVY5B9TKSEJHZydMdH45kMqzzeNFXqTEx/rOwKxe4KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRN8p9iEbPCYsVh4M7/EQ/+15My70K/Xt5poPI8oSHwUxOC7tQPZVZmU3z0J/b2bu6lTe78TNWFuG92eLZgPo20jDcoRBwXnjwORzqcqAfiLJX0PE/LVAkzjlBI2c+VMfGkqH3/PRotk3nm0bijktqQUPxoSqpjauN7JbUbwg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1iLXXi0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1iLXXi0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eac92f7c74so38072265ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420225; x=1715025025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t66m2yC6w51sUPxTLrw0e9BFXrR1zy7lTroSpOOOXcU=;
        b=X1iLXXi0MX+8PwCMrN2iN7K9/Zl3V4KsI6RzyNa1mvlctnAycjOzFwib9SZsHVb1UP
         QLtypdBLTJK4UZzKpctrh6L5HXRV9C2gDBRqq0KbQscfWvoS5iUc29+uFewm3eh5nnXP
         6KOiXLVpCOx6cgtmo+8The9Sebsi0EHwKJhks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420225; x=1715025025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t66m2yC6w51sUPxTLrw0e9BFXrR1zy7lTroSpOOOXcU=;
        b=qz3lwhoR9F51v09EoVB4mhPpt0QaIGy60MF5a91C2C8taeld6QSa0GpX8ssUL0QHbi
         mdhBCi/09J6pK8ztYgha6/kIIZeBaOpXqcJh2tSSOeNieFjn9CtZ3Ntm7RWetv2WfInD
         /PcfnVuuDSYtgeyFUGI/cXmqc7ZMjlwlVf9+/pyOW0HlEC95A/sK/+xFo7s2tIHm11qc
         ht3A+Zrh1OMupUa7OAN6M1WCIWYJFAC/Ksz6HZNWNuo7pD5DP4Gix4JmevYO2jLIq3zn
         RNQOSjHBkW85PR2FDkXe3NWBjpfG37GwwmmNy/N03voSkS07HMejY0MVGAU29lmBb3HW
         d0RA==
X-Forwarded-Encrypted: i=1; AJvYcCUa4gZjPNB9yOkezGO+dx2XPRMOdjqBb66QloqtczDYXFxVOo0Y3QoDQNK2TR8+bJ/24qn34QEqaaPYmckLYt64v1vJEMnweL9lzVJDt09k
X-Gm-Message-State: AOJu0Yw5VBaIG9uUFAg94IokpmnkxN931iWLkAPlFJo7YsL0585rklyg
	D0r2vaYz3/z3F5+z9WdmfpV05/ev+LpvLcNYdWjciLEgeDe0FtvpYtoCb4987g==
X-Google-Smtp-Source: AGHT+IE+SteDEJUNTAb7/nI8MNDpW/XVg8ijQNerSCdwLAPwwr/v5RyMt4I/w7vZ1LzWcXiblxshPA==
X-Received: by 2002:a17:902:f7d4:b0:1eb:5b59:fab9 with SMTP id h20-20020a170902f7d400b001eb5b59fab9mr618246plw.53.1714420225318;
        Mon, 29 Apr 2024 12:50:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm20699547plb.307.2024.04.29.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:50:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:50:24 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202404291250.FA94E630@keescook>
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
 <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
 <202404291129.F261DEA21F@keescook>
 <90ddce3b-1ad5-49be-89f9-2f3e48d73e19@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ddce3b-1ad5-49be-89f9-2f3e48d73e19@embeddedor.com>

On Mon, Apr 29, 2024 at 12:42:23PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 4/29/24 12:30, Kees Cook wrote:
> > On Wed, Mar 06, 2024 at 10:18:59AM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > > Thanks for the improvements, however we are mostly at the end of
> > > > development period for v6.8 kernel. Let me postpone applying the patches
> > > > until closing the next merge window (for v6.9), since we need the term to
> > > > evaluate the change. I mean that it goes to v6.10 kernel.
> > > 
> > > Sure, no problem.
> > > 
> > > Actually, I'll send a v2 with DEFINE_FLEX(), instead.
> > 
> > I was just going through the patch tracker to make sure stuff got
> > handled -- did a v2 of these ever get posted? I don't see anything in
> > the tracker nor changes here in -next.
> 
> Yes, it's in linux-next already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1d717123bb1a7555a432e51a41709badf8545dba

Ah-ha! Thank you! :)

-- 
Kees Cook
