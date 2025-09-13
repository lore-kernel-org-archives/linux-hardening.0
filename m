Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25A15D1
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744961; cv=none; b=NC50LJj6wEj1YexmX/VmoTnK0p2TOVYzrbCxV9+VZ8P2t5LJIy0yhVov6/5Xb2RA5GyR9OP+TYbxc5oMJqxY8kRk8l//KopVxRHB7R+PiXl2BGk4m7hLFMzPEHkm33EYOqV4pAdSeRnyb3fq9qPp1ocn6VSD4mBDnjGEGLHKtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744961; c=relaxed/simple;
	bh=fxnPDdvPd3c92wHByPhQ1EnrEd6j07zF/rSvscb71uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCxnkS6L86dGJjQON9O+tGyK7txK6jHSUbFKjqKI7Rl1oK6Rhtq1bIeiz/tbAFVBUOsD32kn78+2o/Z3qH9eIYKRDoteD/i96dFFHEdJt8+Qom+5uCiux6StdqrLnUNzdrufPXwjnW41Pl4pRmQaz/wQorlZ8ZVP4JKdYXa3TQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6cBb4Tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6cBb4Tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A626FC4CEEB;
	Sat, 13 Sep 2025 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757744960;
	bh=fxnPDdvPd3c92wHByPhQ1EnrEd6j07zF/rSvscb71uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6cBb4Tq/tikcZ1u9aKHiraOOzUgIy20iZMXyS4wCzWQu2oGgKh5giVm3npahhU1Q
	 kv/DGPpCxliILgYGmZnQZ52LxsefacqEqw1MuDdCC3OenefWR5ZYR8irVGGPESa8SB
	 fybdTlxhMVtB0snxCKCPiqe+84BXun+xvdEtzfqR7x6Y7B1c9/xiHiINIW0USNeM6b
	 8CaHkDGkDKEv6YPyQ2wMrojt3udpiAGembtMyziLH4WSfllyZGmwsTzpmvd6S7RcU7
	 gfqZy7Ckhv99uarDJtgQ5pyZ7wF4mXeqj9KmLSs2c/OGIiI/T2+L8AWDySWgzoTqe1
	 Tac0u+rwF31CQ==
Date: Fri, 12 Sep 2025 23:29:20 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202509121443.77F7CF7F@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
 <A356F147-5B23-46F6-B05E-3BDDC81A768B@oracle.com>
 <202509112321.BFBE82ABBA@keescook>
 <40B4B0A9-FC8B-4681-850F-88D8CE525210@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40B4B0A9-FC8B-4681-850F-88D8CE525210@oracle.com>

On Fri, Sep 12, 2025 at 02:01:57PM +0000, Qing Zhao wrote:
> 
> > On Sep 12, 2025, at 03:32, Kees Cook <kees@kernel.org> wrote:
> > 
> > On Thu, Sep 11, 2025 at 03:04:01PM +0000, Qing Zhao wrote:
> >> 
> >> 
> >>> On Sep 10, 2025, at 23:05, Kees Cook <kees@kernel.org> wrote:
> >>> 
> >>> On Tue, Sep 09, 2025 at 06:49:22PM +0000, Qing Zhao wrote:
> >>>> 
> >>>> Why the type-id attached as the attribute is not enough?
> >>> 
> >>> Doing the wrapping avoided needing to update multiple optimization passes
> >>> to check for the attribute.
> 
> Do you remember which optimization passes need to be updated for these purpose?

I had patched at least old_insns_match_p:
https://lore.kernel.org/linux-hardening/20250821072708.3109244-3-kees@kernel.org/#Z31gcc:cfgcleanup.cc

The rest that I patched were about dealing with retaining notes, which
aren't used any more now (an attribute is used, not a note).

> >>> And it still needed a way to distinguish
> >>> between direct and indirect calls, so I need to wrap only the indirect
> >>> calls, where as the typeid attribute is for all functions for all typeid
> >>> needs, like preamble generation, etc.
> >> 
> >> Okay, this sounds like a reasonable justification for these additional temporaries 
> >> and assignment stmts. 
> >> One more question, are these additional temporaries and assignment stmts are
> >> finally eliminated by later optimizations? Any runtime overhead due to them?
> > 
> > Yeah, they totally vanish as far as I've been able to determine.
> 
> That’s good.  Then you might add this too in the design doc as a justification of the
> New wrapper type, temporaries and new assignment stmt.

I spent some time today experimenting with annotations and discovered that
the KCFI RTL changes actually ended up solving all the issue I'd found.
Combined with moving the DECL attributes to TYPE attributes, everything
got MUCH simpler. I'll send v3 out soon with all of this redundancy
removed. I want to test it a little more first.

-- 
Kees Cook
