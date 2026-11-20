Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191535;
	b=e9RMkNSX5QhDLSFK2tAs5VAdnMbChSPV1HsGj2wU5WH+c6HMVH/Adg0PjI798qXQLrkR
	 TeA7NZazS9Cg5VK/H8YlSqcOA4CX81MBSMWfXFtBdFZLIIPpNMGmsKdRoFZ/8CY48A5IN
	 ETWC5iwP8cIrugeKWjW3k/Eiyl0DeM4VxxlxGyKXt5XIqkKs8//MtofRhKNtJS0zY34w1
	 qDAl1Ht+91++pQo1X9N4evHQ93IYO0yaxbNPecgXJPI/JEGqWMqthhsgkJzjr7OfSc5XE
	 jiXKXejS/2QDpwRnZTmh3mCStuwHPsQYmlwmeiDLy0Q1dUpBxy5yDt+fULFrs4/QbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BrCnzItk6Eo8xbqsyLw/nHqEQlRmEOOyoUz0lwAU35A=;
	b=2PU0yp2hmeiGrx0CQqc2jzCdltDOGmdiQYNNlL3LDze8JeG5ihCyUQZ5R99ZPqFC65Pu
	 giw3uaNgIPlY0U8aX+j4wpCUVfEPOPrtQF5p1qR65mcdklyB7PwnZhg+/XLf+NeIgM0kk
	 MOucDl4n86b/ZlZgY3J9XHkNj0uTpZIv4ASH/VV+haKth/vzHs2TGcCEcoVCK+sCa3kQq
	 yzQELvDD2Bd2bdHc/5/+tfqF3OXHqi6eNRk9zS6IHAODm6KujZ6NLZiqsRu22Ualy6JwP
	 VEDIwMLVrK8wI8aMKc8d24tkNntnHO0+AI+fUpCvfxF3jJgjbpfevt+vEJpDvFBGfuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymi1AMt7;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CB60A2605
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009CB60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymi1AMt7
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so8504525e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191533; x=1795796333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrCnzItk6Eo8xbqsyLw/nHqEQlRmEOOyoUz0lwAU35A=;
        b=ymi1AMt74EmtO3KpNPeBmxGn936FaAH40b1fjOJSBMNv/rsqDBZ3xw4Lma38K3I3HV
         zk9Pf2EExgDNeuK1Ppyof9RFpYwozgTPJJABmDpweEFNa4uA9q2hiDa7RCcQDSSxfsLr
         uHJjqbltnPBm/SL4GBqH6e7qDuEqvU2QdR5PtyvRfhBnNUm73AJcmMWWqjoU5laS5Mgi
         GkoHBUrbCTVv1mEaLLgyNLOQugpSqSDEe0xCwaU6sARJ0Sfqbb+mdOEy7u6wEuv6J0Sk
         OfZeUbzzvKBY9pdpBzDRzciqNPFizYsC2vF4sOiX/Oq0SoRk8neAm9VOAZq+aEl8eLhF
         Xjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191533; x=1795796333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrCnzItk6Eo8xbqsyLw/nHqEQlRmEOOyoUz0lwAU35A=;
        b=dO4IGC3MrRyMfHVTeVqsALJdwWKSy9unsCuT5Mp/qLVjOTz46VhmiwY3vvii5/DObV
         SDYExUuxScd0lLfqd1ecknR4yCNWV5/NwYhKV1rFo+rHph/1nehWZI7fteHl0ZGVNALP
         rP0zTTtnVG3n89ThvZlGhjKhWG7QPABqZzoIKVFf5Nljkeel2LBiOKY2yZGtk4Jx+LRK
         AHgcyuepR47PHycdP1iaIOfsK6gyla9GZoO3kg1uTUb9hcaaiK35JXSsJH4h2VEeIL0q
         WNNW3KzDwZtwidHAmLzMVpXZDMgNwk7In1M7hHRfPIBy/Pt/O7xnPEI3emPpgkHil02n
         K3gA==
X-Forwarded-Encrypted: i=1; AL+hErE0uUHxo6MkFYwlc3WuF5W2jfS9IQJcnHMiwpAsXMISs69QRxcKGeJ/ahM4LRGohgkZ7pb4p1Q4vdnGDKXCO48=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h2HmzFB/vCe4AAT1bqhupcQFx0OtNMNbKibbzRH4V7y4/fa8w
	40+1Xb/DGxNOCGkewsq4wrTW/ZMqlaFeTf+zZwVYEtlUMuOxGddEKtZc
X-Gm-Gg: AYBFou10T2mPwt/X1dLjAF7i0uGuZd5Q8JWdYop0OwN63lKKEcjmAskffYwUHJ+kHGP
	ARRcC9z4TnRXUwhl9hCXlPjfa0H+qS7XKnDuGI0Fnf09hl0pU5Novnqg2kbQAV+4sICan1kXWtI
	QJfRTOWjrQQ1iDptvHzgWTq1pChRlguIfNDSuJPMxdgivzg3x5PQITFS8v8OSWpXo2mtHoLRTxS
	Rpvg+BjMPt1JRl6l7siamBW9/x31lZBtk66iVqaiK3OJa9qWCfyhR5CwRqjbDJ9jpGu8yLV7gjq
	RwHiM4iQF8Pi9yJGoon6ec4J9vF+dv6Fej4jJva4kYrO03Z8K1WNYRVWr9VvdG6KYk57/c0oyrV
	LMnDendcnTXDidCWDhg+EkiZRbNXNqFBLkgQ2bAtUGNalzCud7D2MUb9AqTCSgfHkJkK1avMa4W
	6vnqPGTnZeHYTlM1qC14VU9OzYLh9o5paXqbXmqFIimGeOPTib+hQcDZ7Tza06T6i8oPx1wVsBh
	vqfLfCtAS/HLhUfrncLeP2d/BdohfrLoDdicIY6illAfMSReRx7ZHPEY+0XWriHrE7DdMce/EmV
	8+BQNn9ICYmirLn2SeIL0t+p3x/hBCqSMKfsrXhG5jZmJLOEW4DCWDUXErL8czSjAA==
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id 5b1f17b1804b1-4bb8881a890mr80104035e9.22.1795191533093;
        Fri, 20 Nov 2026 08:18:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f278dsm47042095e9.0.2026.11.20.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:18:52 -0800 (PST)
Date: Fri, 20 Nov 2026 16:18:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 hpa@zytor.com, gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
 atish.patra@linux.dev, dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack
 fills
Message-ID: <20261120161850.5b5fec5e@pumpkin>
In-Reply-To: <20261120153539.GW2668564@noisy.programming.kicks-ass.net>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
	<20261119213147.1094488-3-usama.arif@linux.dev>
	<20261120104534.GO2668564@noisy.programming.kicks-ass.net>
	<20261120140200.53ec2557@pumpkin>
	<20261120153539.GW2668564@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 16:35:39 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Nov 20, 2026 at 02:02:00PM +0000, David Laight wrote:
> > On Fri, 20 Nov 2026 11:45:34 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:  
> > > > +#ifdef CONFIG_X86_64
> > > > +#define __stackleak_poison __stackleak_poison
> > > > +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > > > +					       unsigned long erase_high,
> > > > +					       unsigned long poison)
> > > > +{
> > > > +	unsigned long count;
> > > > +
> > > > +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> > > > +	if (erase_high <= erase_low + 512) {
> > > > +		while (erase_low < erase_high) {
> > > > +			*(unsigned long *)erase_low = poison;
> > > > +			erase_low += sizeof(unsigned long);
> > > > +		}
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	count = (erase_high - erase_low) / sizeof(unsigned long);
> > > > +	asm volatile("rep stosq"
> > > > +		     : "+D" (erase_low), "+c" (count)
> > > > +		     : "a" (poison)
> > > > +		     : "memory");
> > > > +}
> > > > +#endif    
> > > 
> > > Gemini seems to suggest 16-32 words would be sufficient to amortize the
> > > REP STOS setup.  
> > 
> > That really does sound like wishful thinking.
> > Especially if you go back a few generations on the cpu architecture.  
> 
> How old? I mean, Interlagos old, sure, but nobody should care about
> performance there I think.
> 
> AFAICT Nehalem and later should be good with the 16-32 words. As would
> all the various Zen chips.

Have you got an accurate source for the setup costs for 'rep stos/movs'
for the various architectures?
I didn't find one last time I looked.
Last time I measured rep movs I was using mfence to synchronise with rdpmc
and that takes even longer - so you only get the per-byte costs.
(You can use data-dependencies which have minimal overhead unless you
go back to to some pre-zen amd cpu.)

You get 16 bytes/clock until Haswell which will do 32 if rdi is aligned.
Icelake might increase that to 64 bytes/clock.
Agner has zen2 onwards at 32 bytes/clock.

Agner also has zen3 and Icelake being able to do 2 writes per clock.
If that is achievable for the writes being done (the loop isn't a
problem) then it also takes a while for the 'rep stos' to catch up.
(Then you have the cost of the I-cache misses ...)

David

