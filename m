Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA74762CD
	for <linux-hardening@vger.kernel.org>; Mon,  8 Apr 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618455; cv=none; b=Es9Bl1T1MmZa0XMX9Ib/BNR+dPPREnNo5NkUTWeiqWBBtpu3RY0+R3A5M2L8kxPSkL2ELFeZbngEX73cbiwmflKzNobjG8ygd8na7uF8KC4yrxiz/CHAmiHbe77G4YOyJV1Pal+TVnvZ0+2TDnMMGP6n9wC0V5fe419GJ+1zjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618455; c=relaxed/simple;
	bh=ABYWepUPTpNOjIti27XRT5vSfcJbPAQWDlfjw/lOhZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQKvEP4LCb2s9rW+3+tbgTUwDF9o5uqvLP4g/oMGX/DmiJevxHEtJUDeJ+iFkbbLhgluMntyfDSfrM+b2A8jtQGYw2SlRnN1ZDUhKLx3WGk2opPi2v0ChRD1o7e9kgmmFLXc8+yEWREiCEn87zzBisto3nB/F4SX1H25DDM/iME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A7tfDht1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7tfDht1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so4649734b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Apr 2024 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712618454; x=1713223254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+SiT5TlstlnW48g/wuVm80XsJWvG2bQ8P1YkCxCZTo=;
        b=A7tfDht1QiAasrAarWgQBcp8WjrM0U9g0mZZ4NCgvzol+70SMfDqbCwOKj9bkiy3aN
         3zM/9kN7bm71kuIetoUPLapxRZOM9Rb0mmWODp0EpDPVy/MbcHOrIrKVRMRe48AKCxmJ
         GqhxoZFqH0naH8qdkMPcGDY6ABkAGir+Zwq1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618454; x=1713223254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+SiT5TlstlnW48g/wuVm80XsJWvG2bQ8P1YkCxCZTo=;
        b=RMFSW8cT9V5qeB1ujdrE/raReyZMknBttp2HyT66WbQHtjSgxgguYcqRLmOkX9LdNp
         D/fbRaR0t5HVE2D0c/t0+2o/n2k9pKqD52aqD6brIeyi3g0PtDID+BjXWe6Wy+wsVo9t
         19xlTNEVOLVAtPBpv/cfNEHSxQtZR1TzhC2jfiqsg6AsKGCNvq9Yk8e5RngZkRNJJ/Ct
         IfSCzXKt1zJ6jwAMQl0HrSrvUTaCa3Ov4jSlwOuo+T7DlBXVGDygO8DrAE0V7M6QldsZ
         gL7D9x3D6BZkLB9n9FP/L4tf41EQilXrOI53BibRBWoFEBThU3CdxSw93LrDrAjnVNJ8
         lOnA==
X-Forwarded-Encrypted: i=1; AJvYcCVJL49DUQXkikY334I/EKYLmecBeYRUHJanoGYNJAVDumjT1uI4anhBc0YOi4b40NTZ0+aoty77LJouExrANmk1rbagJVH8xX+r5NEzPAZy
X-Gm-Message-State: AOJu0YwnzFhYonl73j3NLshilWnTNWF7mEDHxGGw5DXVx8iLCM0+K+Tt
	sLdlNNz5EGtC3DhThlh7dQr2vGJo+thd3+rY1/nfWhaT4GJddZUJkbjTKbXGfQ==
X-Google-Smtp-Source: AGHT+IFKJzLp05fcugYDvokyR1XjAmUqpeqvOeGNr/xDGBIzmxdVQH9EoFRUIn9jOHtI4yO1H7vVRA==
X-Received: by 2002:a05:6300:8085:b0:1a7:3365:d8ed with SMTP id ap5-20020a056300808500b001a73365d8edmr9271766pzc.29.1712618453799;
        Mon, 08 Apr 2024 16:20:53 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001defa97c6basm7517122plk.235.2024.04.08.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:20:53 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:20:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] net: dsa: lan9303: use ethtool_puts() for
 lan9303_get_strings()
Message-ID: <202404081620.D050527@keescook>
References: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>

On Mon, Apr 08, 2024 at 09:01:57PM +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_puts() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
