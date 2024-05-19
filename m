Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A258F70;
	Sun, 19 May 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716118299; cv=none; b=WAn4cZMJjFshYWP+VZxUpgO9o2l+WTKkzoceyJX90Ih5+BzxcapUz4noDVkFREVSlKxqyMm1fh5GrBfH5JmorXJ9A7mYeAlAUddDR7pojCEyfw49sceSf5f6n9GEW3acU/jR4iNcgv8rYz4E9DRymEHZkdaP6qWb6byttI0Aj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716118299; c=relaxed/simple;
	bh=ReQMMxzun4YFGhofp27QdLTQlpx82RLAaLzrO32kGqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6HxrHE/qg9xK13eYrpPv0LqB2iU602dlHx1vLl+85Znc1lc4PoAwh/8lm8QWtRPdAIi2g8zI9UUB9bJKgtGnQMOFGEl/Q+DWte9F48hD5q/eP36PNEwVLYGrpxO+Oo+7tFy8bhjwLoHVr42nAJ2Gez/iYBYR6GOCadeXAi47LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kmzqEEpi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJAczcpg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmzqEEpi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJAczcpg"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716118291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5K5Z31ykrIcu2QsUSB/qx6afSiiIrRvFMc4qotL5jc=;
	b=kmzqEEpigp1LsbxDWlgB7C1vkKQfEg62EQYA9mNwmCkpNOeq6IiIKSpNkFdHa1pGB21YZC
	u7mJsk9aOYJh59ySHK06/FDzw9T2nz1rJ19S4GbShg5d5KMBRGC/FYfcfVGIlEEn0xmj+n
	qLas0q3+0ySq4OBaBKH1Yb1EIob1yaTagPe+cfd88Qa+HHwTrfl0/XKyrl4PLZZ9y8bnA7
	lbQWCBB1ezDWU+Ox+ndy7kuc0S8/t4ijYghifD96nO3rcW9ehR6Q8IqTspcPAeo2ebcKjl
	Rt2oj5ApzHkHkAGofgmTc60eeSCpUt7WuKCtZCojzyZEvc2yy78aBuWSYT11Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716118291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5K5Z31ykrIcu2QsUSB/qx6afSiiIrRvFMc4qotL5jc=;
	b=UJAczcpgyYTRmoY1piF//aUNeA07bL4M/4KWLEURlRowFHwu7j+VARN1iNS3c/gUvSP5A5
	6xOCkCVLrzJ4TGCQ==
To: Justin Stitt <justinstitt@google.com>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ntp: safeguard against time_constant overflow case
In-Reply-To: <CAFhGd8q_zgWj+up87k1ErYJAiTuvkoeiAZE066Nf5gRqf0Q9QQ@mail.gmail.com>
References: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
 <87pltjj1bs.ffs@tglx>
 <CAFhGd8q_zgWj+up87k1ErYJAiTuvkoeiAZE066Nf5gRqf0Q9QQ@mail.gmail.com>
Date: Sun, 19 May 2024 13:31:30 +0200
Message-ID: <87le46hwbx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 17 2024 at 22:18, Justin Stitt wrote:
> On Fri, May 17, 2024, 19:33 Thomas Gleixner <tglx@linutronix.de> wrote:
> I accidentally sent a Frankstein-esque creation of two patches I was
> working on. Not my brightest moment. It got past my testing because (as you
> pointed out) I only ran the reproducer against my _fix_...

Shit happens.

> Let me really parse everything you've said and v3 will surely knock your
> socks off. You'll have to wait till Monday though :)

Take your time. There is no rush.

Thanks,

        tglx
