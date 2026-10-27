Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119065;
	b=v3Hoh/QCfe34xLFJM+pQOQ6au84ZeD5RkEzr2Gc1+XfGQNXsFVykxbmF5vNVm1BWMCn0
	 9421aT81c+LLbqhBTRRZQXT2SunUw5CUwfv11/PZ6SBE2CU91skk50YTxwfXUncMw/QhR
	 XfipHIj78erKpZEOO9xoz1dioxibv18RD/yal39W3rACyucaXDNIqdE/fff6Wh3EJD81n
	 g/vzaVv8WMmxSf1a5Yg5stx0huPQW7gecIw09rR5/IwO9pINGHHH7cLZOojclGdlUwPpc
	 Qb4v0/RNFGpVMb8CA/HqHiY9BI/lFlZpBOccQO7DduKU7mLgNtXUyvNPQCPVaikYDlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
	b=Z1lHTgGx22t7YYFz07vTkTPDdT64e9eAdxUQCYyGLOuhF+T1C2GtgnXr4S1OCjWM0n2Q
	 n6427EAh8eMJRScFNupyaVIqb5qlEXhpqjgwgTuURL7AFY/OLhSeUhdiKG7RJdmKXK3Oh
	 F2292uLmfBj003lySTgq1t+PXP2n5i/5c+CQU3M/i3C+m3ZXi663Yf6i6mojf2YjgQobm
	 nb0lGxcsNEew2wM4KRWn1twpol2329rDpl0Z6KDWknF7snUmueTffqnTiP5XIwXU4v7Wp
	 U8FyO4FPHtdAyVyO45DsnMUkl28HotX9vReytgbZ0s6mnAeE+gyLDSFYZvq3Gct2h4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jp0oF4Ys;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FD606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jp0oF4Ys
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so78435a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793119065; x=1793723865; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
        b=jp0oF4Ys897XRGpeW6RKR/fHWs0900z2eISbO0/7YoTTJ1fFarjXa0F+Tp0M1QIRaV
         1g8zSJLLa2lNBbVlsUVyLp3zNvrpzucfIl+D14Xq31PvhpEZ+hIqMTwTXDul/RmgikfL
         CjByDjQ1ylYmmxEchddCELFvL65xpS7fbntKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119065; x=1793723865;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
        b=gLLR5gE0UmchpVDqfPnQmX8FmCLtviJSAjE/mxl195MN07S8FrAXXoyWJI90YN2/Uc
         iPlnLp8EmNFAUY+pGDyYFxXrBaZIzi0isfBv6++7bOkIgXwpdQy8TndGvF1CzU6dLrx3
         UbyOBYd09PW/jYdgZKLQ9vipnsFy0DO6W2k3LyW6vvjDim4CnChPHQysKDlevWC3x/Xz
         +91L2o95q1fzTYFwwY4p3i6y50VLovYquJ97uiWUB1GbEsB2IcrgIoGMLJz5V3U2IIu9
         gwMiXkCK6B5m+WqjY+s7dahURjhUMowVOSlPZmbVbW3QE02/7mquj/cU3Alp8s4H5LAD
         gPXw==
X-Forwarded-Encrypted: i=1; AKwUvBznoPYeLWoQWp3agRO+riAkDaVfZp/MDcPWqCR5OXXr6eMV5xB6C7xvRu2UBK7ZYno8Kg0+bpLG3YAry1HVGKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxqxyyJw4mMR/Z4JI0UbytaYVWk2kssUvO6jN5EnHLrUTpE3mW
	yfChJIFqpRKcnZaIanNG+P0DwOu/6enBe9U64MjamJzhnO6bg9pwO2Dp6g0mIpcLfIw=
X-Gm-Gg: AYBFou3doWG/v3dbSsHx1urpwKyY0O8P+T9TyuL5T/learMwydOQOWfQo6QQci795pd
	2wTayE/sIPsGHKrgRRH2GW4rGtarwoRKzTIPjIHgAejMqNOyI6jHg+or+X0nJfeg54msTQNmmPg
	f4m8A1nCMCCSt1GVNiiPNtiJhRN9v7fN7E218/iuoDyP3nYPne5qjFI2PkOrRs1AG+A6vc5KMxG
	cOqIxFsrksALKZ/RBvl+hO3bbIiVcxb4OJgoAl2oIetRcNQeS2O2vb+Zpa9Oum7GYGWfzR2ylZU
	h7SRoPFf3itt+pNUh+d3sm1gvwY9gpp2xH/JPMq7iYNFoDLFrqSJGPkUC+j3hnDiXFxHBXNvUrC
	lqnk/zsnNAV+0E4a1FfHsyBcsiDmuSO/KHLmeVczxApR1gZTwOIR8s0zudmN289Xtqxme2FmTZc
	TEF4NiccIdVRbLKm1cRLXj5AiuqRliHwCyPMm6p4Dj+3xzkrf548PVyxicqRSF0bAatNkiY03Ai
	cVmcUggwf/fxyfBnOCgIpWvttDfYfeyzKZmOj8TimJP7eRTa9PKow0Rt/Uij5TdG2IaYPfrHsMV
	BjZEZ8IDl9RWcoUYjbNS204JNLSlId3XCCqYRmiUulD+98aK32aJtZ0XaUkKYn5zbmzud9nk2UC
	WzeGkQ6i0HsJF2NTu430ifB0=
X-Received: by 2002:a17:90b:4cc4:b0:3ac:b197:1a37 with SMTP id 98e67ed59e1d1-3ade9b2d399mr8594261a91.3.1793119064572;
        Tue, 27 Oct 2026 09:37:44 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4041fafcsm5635829a91.0.2026.10.27.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:37:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 00:37:41 +0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] mseal sysmap: Allow with CHECKPOINT_RESTORE, default
 off
Message-ID: <auDTVShTfZ2et9m4@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
 <auC7SFhV_qj-agQp@gremlin>
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
In-Reply-To: <auC7SFhV_qj-agQp@gremlin>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Ok, sounds good. I'll drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON, and fold dropping 
the !CHECKPOINT_RESTORE dependency into the boot parameter patch. Thanks!
