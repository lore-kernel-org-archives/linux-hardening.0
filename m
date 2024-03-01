Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336B3DB81
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325955; cv=none; b=U/2Xl9Ug6XGcO9zkrFTychK3XKBmkxFP3/jRI/dT78LJrqOWv5MSCDDKfshandJZ+6PJUi3UEKbSHwfVxqiC4/UTzpMQXYRF83BJl3ncsMCBi+82AB9LxDE0Zdf5b5vOrUXYZNQeqjpgfY2nOA1LQQ0C9a5oetkmRBGvdOarrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325955; c=relaxed/simple;
	bh=L1mnju6b2hWfk4qgJMRiUjxIH+2I4aVtoC/+dDgCUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jodL9JXDMJQDPltP4HiYktohyjtCEtsB9cmPvucGo/Ajkh4myNX13zplKQLROUKoWTw4wgbe9jx5OyJhnt4YReLIeP1vAwgp4SSLYBcXl8aXHcoAcehqItvSBQw2t7NXev0CNBm5DCG9nbHFzXEA2hUILWhioXacmKnhPVLwKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QhBpF2Do; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QhBpF2Do"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcd6a3da83so19237815ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325953; x=1709930753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=QhBpF2DoqIVWqzjnKB0Urx6e8xhkcdvuKCkBUK/iB6JzHaQkbWQBfmti6OcntLsj5Q
         22KZO+E6zokXeaSzADTynGBeS9IOp4/7HkOTnwrd43V3lQ9+23vumfpg5oB+VrviwomM
         wFMALhe55PpNIKWFBnCfd+dPiXmIJ2kQgCsIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325953; x=1709930753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=ohHwAKkHvR5ag6YuoDLGhx8GuCQLEeN9SEmiDYEB4hfhqESYFq01rmTzBvYZ4TXsdW
         3uMXB7bs5ulqYmkiDer8iz3YgrHlTj8pGsx42ZsdWdDYpdXQVBVqeXF7SE8cToHI+GMk
         Hm4RYmnvnEdzanm5BQ6NDTBNGPge/iBjf6sN6vi/WugH6kU4u8dOpw4BTEArBti0uP0G
         UVtZ2r2ECCEMUNIbJnBKVeHHiGTwF4UTG62XX14iRLZY0kM2I6jbE1J5j5Y4vsiIcGZH
         tyLieFNouT5I5oPN8Qae3b6BSocrpE+gRStODK8CXMlCWAUqEm32ovbFRWwx31BKTFeK
         4qdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zrP1nt80aneK9ln7tQaVO3WAtWRHfeODWFw0DkXn/uAmFvdzvs5SHzxApdCpDL7B2dMykpEPYRW43Us8F64WLv/mWExS20MiYM6W7hgs
X-Gm-Message-State: AOJu0Yz0rbddBf9Yy/B8/JCJCOdJkVoBhaPnL0PIVH5crFFV52VqMEwR
	KR/XMGVF9wnoOBLRPRwNEL39ydnTv3duUrxYP3UQQ5FmWyz9rAh+0WvMSg3iQg==
X-Google-Smtp-Source: AGHT+IEeHOtGROSfO7InBUOVtUOBB5GkfEa/BvdxAw10MRzeVk4FVzrKuCP1P98bzAscQ3onwNP8kw==
X-Received: by 2002:a17:902:c146:b0:1d4:cd4d:923b with SMTP id 6-20020a170902c14600b001d4cd4d923bmr2488161plj.54.1709325952968;
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dca997b3e3sm3892081plf.65.2024.03.01.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Date: Fri, 1 Mar 2024 12:45:52 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] spi: axi-spi-engine: use struct_size() macro
Message-ID: <202403011245.3BDA347@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:20PM -0600, David Lechner wrote:
> This makes use of the struct_size() macro to calculate the size of the
> struct axi_spi_engine when allocating it.
> 
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
