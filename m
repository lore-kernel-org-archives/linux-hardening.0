Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDE22D4F1
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575788; cv=none; b=I7d8VhT3ZZAGCpQ1zRCmRRoqB2VfGswD1WRzU7B+ja38aBn0WInPhKf5worIwjXmr05pcBXsj8wKIGMaqMCOG8DeNdFfiL5WsXiajI67EYZuhSOXSMZEINrym91If4p0TrdUDxqI3ahZlHkFXSyI941WMdTE13Z5jO5zezi8ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575788; c=relaxed/simple;
	bh=+EhBbp80jwBMA2nDG91LSVQ9PIRj7PpTpIe5yr09xfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgageHzJyiJ/bCB0tqpa0KUKlp0zotS3r/YUMdJ6g8awkSslA4Q898ZJ4kAp3yPermvHzzXsaL3d8Gup/pJugEMW7kSTKV9dHmO0ATVfHfPfymqaH2HjpO7j6mEwWhaivLOX70kfeYLVdxg1Dr6YMseAb7ShVzX/TD0/i1rrwoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DdM4xUVy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DdM4xUVy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xj0VToSUfAMrjV3lI0PgVBsKZDh0ZuveTkoTBq9az0I=; b=DdM4xUVy4j1QG5NTOabx1j2kCR
	wyIkLHJtD2Xx50St1yOdniH4EUvTPcfGcAKU5aAScWv/6J7oL8KGuDVTF3Od+Iy8vIhbk/SlELIoh
	9+8T3u+rT2EXgX2ePVew46TEl43lRzYLqNCA/OHAHcsJdK1F6ovBdR+JJOC6V24HoQbN5fY004sWP
	8IDa6CG+JxFXDs9DCvci3mLCYspWDu8kiFV2YpC/F1lWPQWBT+3FesBMusv/eUY/OpP4iJ4qEQ91x
	PozVsB4HTRHp+FKRh22bXy9nk37fuSH4NvS1QemMooAynIUgsvzCkuRFQvSBYJFjdtaCi6DwuHxcB
	s7bVljGg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbkO-00000006c3v-3f2m;
	Thu, 11 Sep 2025 07:29:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 572B0300342; Thu, 11 Sep 2025 09:29:35 +0200 (CEST)
Date: Thu, 11 Sep 2025 09:29:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250911072935.GW3245006@noisy.programming.kicks-ass.net>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202509101705.92474D66@keescook>

On Wed, Sep 10, 2025 at 08:05:11PM -0700, Kees Cook wrote:

> > > +/* Check if a function needs KCFI preamble generation.
> > > +   ALL functions get preambles when -fsanitize=kcfi is enabled, regardless
> > > +   of no_sanitize("kcfi") attribute.  */
> > 
> > Why no_sanitize(“kcfi”) is not considered here?
> 
> no_sanitize(“kcfi”) is strictly about whether call-site checking
> is performed within the function. It is not used to mark a function as
> not being the target of a KCFI call.

I'll once again argue that __attribute__((nocf_check)) (aka. __noendbr)
should have that effect.

If there is no ENDBR, then no amount of kCFI preamble will make the
function (indirectly) callable.
