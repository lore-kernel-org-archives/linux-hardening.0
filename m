Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201264;
	b=cyE+u8A41j3uDIcx1I2oRhdhwYoc98T9S+tHpGZhoXuhW/TQPQp2mf3cobHNeJ2ofgrZ
	 uP2s2SxiFbYxqdWNOFAD2os2doTbS8944lixvJ4//FZFZUwPxaOGWnqGXTIHu4RjiI9M7
	 4Lfuu80S+Ne98IsMow2U4AiWTAuUv/ETwsQ5c4eyjpc6/SUgnaBa+lx1TIsiaJ3cYuApS
	 IuBoE9ukeIa9iQdAmuSWnjiJyWcLV4fFU+jMfFKCsrOA9KU16g/mwOme+jdkjFcX4IoxN
	 lAzeozdZPtskhtCCS5r169Ea4kASGuZjMV+ln22B4p/uB5iq2tXjQcio9Cyfm4015gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=RvKduUdpqvn57pENoGLB6F2PlOffkxBgVZHDYg1GsYI=;
	b=GoOteFPW6MjdaONBwo954USnmt7vh5JgLD31z+yKy7P+yjPXauvX+qjTyZraKzeh4DvA
	 vkp+yGHNdVAlRXnJNxKV10EKdzwSMKQbZUMuR2ro60biObAMg/IlhSqbELn+Ab6gs7bTF
	 cH5jEpks64jT6NFAx/Ai7KFTALyszNvzZl70lQ5cP+PmSC2ZY3tZuBGYIxUiwWIFPcKZH
	 kNyY6kodFriR81d5+1mn/ErbKzumBrC7tLcvR5EN1/rYHtIPvGbW6S5noN+pNrYaE0/tj
	 a/xXRPSLQu8TIUnQDnhdNV6m2+XspQAkzCeCsDHYTv3glRWpRWYbKVkFKdjrA06y+wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=hfRxv3UW;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5E606A31A
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 15:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=hfRxv3UW
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6d290b10a35so560731eaf.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793201263; x=1793806063; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RvKduUdpqvn57pENoGLB6F2PlOffkxBgVZHDYg1GsYI=;
        b=hfRxv3UW4853Ya5L+aMGqL9c/zDLOUs2TFKfwaIJCPDx4yTq96Z1eEw53AWzmRE7zT
         LCES5c/EKioiYR3UK0H/tQFybpmUkk0PTiWKTVQ7MDAdZ53nYTpkmdTo4nDAxFluoWaP
         g67IkK7SsBkO7Mdsowmvv/nQBdTN7DvEtz7ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201263; x=1793806063;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvKduUdpqvn57pENoGLB6F2PlOffkxBgVZHDYg1GsYI=;
        b=N7qk2k9loJisliW9I7y81BE8rclyBeGwFyUoonK7uGDZmUzxZYNN/+3JGbArh2JMlf
         uZBjBtpI98LSxL9a5U5x9r0XDeBW7jXPN78ppR1x/PzDpkTeqNxyfdnqM6yXU9bKJHwy
         2G7ZNZ+CDdi6F8h7RZQHutC8jdV0CH6wX/4qITcAP7Aupj1TVxPPB5B++NKyQWBgvNuP
         xZzdHF6cPvmfGONW7IwVjQXcUlvTDj0yttkZsD80WV5fo7uIikaoIGCBUvkx0iUPKYGu
         neUVSM2ulwMxzexP6ex6cgcZbqPgEQ5m+u0RXsdVFMq4cGfzb2U8R/P/bjR9uQuCHWbt
         iKQA==
X-Forwarded-Encrypted: i=1; AKwUvBzBSpFE8FLIbvfSQtUZmBH94DFTamsGjUEFKFhS1Hd9vJXMEfNdhMMBuFqZ2CcdV5e2Z5L+6sHLjnWRf2Ejn58=@vger.kernel.org
X-Gm-Message-State: AFq9FYJURj1vrcTDYGyvQXTAQfB91DjYSKTrWmwrbajMsxyFXGGPUa2P
	6cWeUTaaIBYY4sF/2ZZJCOhD5N8oD9PSSLXIgGElCt88Yx/qdSRVIDOb7z8jmjsFvSY=
X-Gm-Gg: AYBFou0q3N0g2ELfFJyyCe2ghb6RIq3ApQsVzspTH0oC3qrB1w64dUUYTKryKDHnT08
	xVeWzsM52zPZOtAzQhr51uqzZ6lcJobH0GS63SmPmANO315DRmxIKeP2QxkMd3RW1NDYS7jyVo5
	DB2x6FczCbd4Myft6DtL29HXAwyTuQ+PZn1LN4psd3wdOtEC0AhYFgZnGegHALO/SXqXx6fOcnv
	78b1ws/G8n8L+pBzDrpc6cGCHj/WxrmErWzFOwOWulmtflzDfNfeoamwB/dalW/N8mbwBW7sRH8
	/WR9gSAoUvjkJ9KdQt3kScwLBBMGiWsgPyUeNekNRcmMeY84IlYQ5ZHVWiC6a9JC33597fSbc0S
	EacFxCGxlFV2jFX6vulL0SHvijLY0/x69VhevzG7kWbA1d+WBzHnjU89Q/8mRz/ci0HI+BhZ5Vi
	RtcUtXAAd1I7iKDeET49yx3p/R/A2Qxj+ZHIvWQHU0+hpPSYFG0yb5debPUFXIBzVziIM+KIO/p
	TFNVdVsgq2R/Jpy83Gk314m/1K8g19bcnc9BIkNWTcZaNcZ/bUo9peT88ANS3T85sWMNcz3hVsl
	jeXUxudYzgsTdx+ZIcSoPhA0Jtflz8DH7ftQaSWTxyjyzFQmMN8/L0LtmLvBfbdR/lq5Mau6S6X
	UHZemgG4o1W6XrD3EwY7E1ukryudSqAsuyembQpxqcU1weVBwORkE6mqT67mycTzpd9t1uEYRRJ
	UsHoa5PXFXXS5Yz9dHng==
X-Received: by 2002:a05:6820:5718:20b0:6f4:d9d4:3948 with SMTP id 006d021491bc7-713ee7665afmr996593eaf.45.1793201262701;
        Wed, 28 Oct 2026 08:27:42 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71429e7b7basm1517856eaf.1.2026.10.28.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:27:41 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:27:37 +0800
From: Chris Down <chris@chrisdown.name>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features
 at boot
Message-ID: <auIUaT6LyEI2cXpj@chrisdown.name>
References: <cover.1793086056.git.chris@chrisdown.name>
 <auIN44CnAyzvR_Ll@thinkstation>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auIN44CnAyzvR_Ll@thinkstation>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Harry,

Harry Yoo writes:
>If we end up supporting boot-time parameters for hardening,
>I think it should be all enabled (or disabled) by:
>
>  slab_hardening=none|light|full
>  # please feel free to suggest bertter names
>
>none: "Turn of all of them to maximize performance"
>
>light: "I'm willying to sacrifice _some_ memory and CPU for security"
>
>full: "I'm willying to sacrifice more overhead for security
>
>IMHO more fine-grained knob for each feature doesn't make much sense.

I think if we did the 4 knobs that is a good idea. Given now it's two, I think 
it seems reasonable to keep it as two separate knobs unless you object?  
Otherwise I think given it will only cover the latter two, it should be 
something like kmalloc_isolation= instead. Let me know what you think.

Thanks!
