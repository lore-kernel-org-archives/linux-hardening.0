Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD6287276
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851804; cv=none; b=lUHVAwYZtyaHxHpMCrymgeIGbJUsIgIke715vHOl5TSlmiZgh+hUBUXJyxrJiBBGRPkJZtPI+kP4JKz4sUDufGxhQ3v1kEhLEGEOHzSIMaW12iFSM+5sNlLCgZfYrKg0hY79BjFnt/cdBxRuAJYEiNNy8U80VdjbyFMVuP4xCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851804; c=relaxed/simple;
	bh=GOypwtQWJmJEhv4snrXOWxCuzPzUPdBo4bn1azorO6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yea6a96H3fB2s38ONU8LCyVbb6jDtd18sF5x8cafylP1Wf9UUyonTiP5Nug94SZG0VwJo/y47eO9LPY4oyBx3daxchyqsMWCacxTdR6TcpcfMfkELutafVGLL6MZUSAKPkpPHt0VBFcoZFS0pegB5ChzRLqwpK0b+w8i167SeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJQTxGBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJQTxGBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1B1C4CEF1;
	Fri, 22 Aug 2025 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755851803;
	bh=GOypwtQWJmJEhv4snrXOWxCuzPzUPdBo4bn1azorO6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJQTxGBOoZDz6pnBIAYjKgNi0DOoGB+UISAywaa6rlaCwt7ceNtueTfNTFrELJMop
	 FAIND8pJGUZ67JEPUCDZ9fkcFQ2tZCz3S4D8Pa6WDm/M8d4YViK7fiJVy3SMvPP3mC
	 BHVG9PCkPPIq1ngicWUhJn+2K8T/6HNR9nWX2hFRaQzZQTAUzoY4qju2io0LJBeomW
	 rSK60BqJxvH+tUEE5ukMEULIaIlOd/OMQxD7cdOU55J4VF3+EZee013lZeO7/JE3s7
	 yuB86UUAyAMJXjskLm+q89TF0geo3cbag7EBUsF5Y5KX6p31eXDgVnj/w/gMTJynHI
	 nylCh5noWLsOw==
Date: Fri, 22 Aug 2025 01:36:43 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <202508220135.A0ABFC1@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
 <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
 <202508210916.71079E4BA8@keescook>
 <20250822081915.GF3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822081915.GF3419281@noisy.programming.kicks-ass.net>

On Fri, Aug 22, 2025 at 10:19:15AM +0200, Peter Zijlstra wrote:
> Anyway, I might be able to deal with the indirect call not being r11,
> but it'll take a bit of prodding. Also it will shatter my plans to move
> the hash to eax to save a few bytes in instruction encoding. Let me go
> poke around with that UDB patch see what's possible.

I think I have it mostly working to force r11 when doing kcfi and
retpoline now, though I'm seeing a few glitches still. I'll keep working
on it.

-- 
Kees Cook
