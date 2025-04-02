Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B21F2377;
	Wed,  2 Apr 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636221; cv=none; b=QumObWdl9LTVEJX+2iQh1g9cTA+jBN/vq9bdmWVyc7I3p1aJkWcSCVgCCjJAHibcEz/HkXv3q2fxL9PcZN6eKxMtouss4Svvyb4pGenXRN3hmU4CadBAj7hrjgy5cE1STPNV87yD/cdfyDhm7eJ1em0I54BT0stoU4YqL3GLjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636221; c=relaxed/simple;
	bh=jarzM8bV+gfpjOb7MSUI3rF4XdVi+5ZvGMZgQtIhcWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EYPosuSbCfBWiiyRNqWbrryWdYZ0wjyc4UU2wCwBAsoK5Y/wLuIfI7fC/0ZfsLvBJ4mRyslDiqd0bl+rV+X31TNaVrZ03VL7SgZDrLc69IJU2fr7XNhj2NbRClTnePqLFSpCaYc4RWI7sb9Lgp0A6kS9CFjyLhFOqi7R/4OJw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 406FC92009C; Thu,  3 Apr 2025 01:23:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 31C1492009B;
	Thu,  3 Apr 2025 00:23:31 +0100 (BST)
Date: Thu, 3 Apr 2025 00:23:31 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Alejandro Colomar <alx@kernel.org>
cc: Alex Elder <elder@riscstar.com>, Kees Cook <kees@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Azeem Shaikh <azeemshaikh38@gmail.com>, Alex Elder <elder@kernel.org>, 
    Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Increase length of device names
In-Reply-To: <y5hkfx6tld2khsv2rb7w3k5hlkhfjfn7ndwwj5g75hkdebvjat@mypbmvg5brfi>
Message-ID: <alpine.DEB.2.21.2504021652130.53907@angie.orcam.me.uk>
References: <20250310222424.work.107-kees@kernel.org> <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com> <y5hkfx6tld2khsv2rb7w3k5hlkhfjfn7ndwwj5g75hkdebvjat@mypbmvg5brfi>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 15 Mar 2025, Alejandro Colomar wrote:

> > > GCC 15's -Wunterminated-string-initialization warned about truncated
> > > name strings. Instead of marking them with the "nonstring" attribute[1],
> > > increase their length to correctly include enough space for the
> > > terminating NUL character, as they are used with %s format specifiers.
> 
> It might be interesting to mention where they are used with %s.

 Indeed.  I seem to be missing something here as I can't see an issue in 
reality:

# cat /proc/ioports | sed -n '/EISA/,$p'
0c80-0c83 : 486EI EISA System Board
5000-50ff : DEC FDDIcontroller/EISA Adapter
  5000-503f : defxx
  5040-5043 : defxx
5400-54ff : DEC FDDIcontroller/EISA Adapter
5800-58ff : DEC FDDIcontroller/EISA Adapter
5c00-5cff : DEC FDDIcontroller/EISA Adapter
  5c80-5cbf : defxx
6000-60ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
6400-64ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
6800-68ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
6c00-6cff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
8000-80ff : 3Com 3C509-Combo Network Adapter
  8000-800f : 3c579-eisa
8400-84ff : 3Com 3C509-Combo Network Adapter
8800-88ff : 3Com 3C509-Combo Network Adapter
8c00-8cff : 3Com 3C509-Combo Network Adapter
# 

nor why incrementing the length specifically to 51 (where eisa.ids names 
are up to 73 characters; one of the longer entries can be seen truncated 
above) is going to change anything here.  Overall since the string length 
is fixed I'd expect just using `%.50s' instead.

> > For what it's worth, it looks fine to me.
> 
> LGTM too.  Assuming that changing the size of the arrays doesn't break
> something else, it looks good.

 ISTM increasing to 74 instead might make more sense (I don't know what 
the actual maximum size was according to the ECU standard, but it might 
not be that we'll ever add any new entries to our list), once the origin 
of the problem is known, though I think we need to evaluate what effect 
such a change will have on the size of the compiled kernel.

  Maciej
