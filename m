Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523742153E8;
	Mon,  7 Apr 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045952; cv=none; b=eGVYVsKPLMTZErlLLPIvgDpU6ckt4jlMxTFvuwvvKScz9VSeDjIIAeXk7v/MrhKTLgFFOc2nwSnhpOLTS77iJNxG0KUsv4bKP5ZsLVO6dQY9ntF34nkTxtVAPsMMdpEXfiyqrNQDdsPoeh9nNZt8TYC+6XcrEQZq4O0E7E+hK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045952; c=relaxed/simple;
	bh=iExc9V1RZNbH82yR4R3zK7vVNa7a3hCQ5/uCwMnbJY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwMjpK5hoOGN6vlvaQAVwYJJq5jeh4SyNfXIUoAMol5gF/Q2T4IECYux+t7vb+JrSeryERUfnermn1ahqYJBro28fJfcf0th+3Axm1B0KlAKTRwp648NHHBwicVU79mGXGfImlLltmSQIT/FoY1IUZgdCuIyob1pIATnr1uFyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIWbhSNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIWbhSNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7AFC4CEDD;
	Mon,  7 Apr 2025 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045951;
	bh=iExc9V1RZNbH82yR4R3zK7vVNa7a3hCQ5/uCwMnbJY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIWbhSNnWQLiZ/9F0PpvV82WY2PkfOoRwpyStw9ZwlWqZwT5Cszu8+rH4Wbqa/O1+
	 u6hIbES7fW2u7uodDtT/2aaB41G02QhMZ00McS0hvNxTr7/UUl2fLvgpK58PM/Mx/P
	 dpM8JQuVP7Gkm5whPPMGbpSCESKjZ5WrW75WkTyu6dYXHyic4po5Ky58g4EA41sxyh
	 /YnLtQzpEa/KBA4VM5zBvIHiRQ5K+COLNCSXbaewHkaW2xcGf/0oj14YjFpBBzRQ+L
	 IIHFW30PmF1L+Os8AzH2HrKlvoevb8fUFq+cVESIRT6Y45CAfluCHCToVnbEgv7a91
	 h+5sWqvCNMCvA==
Date: Mon, 7 Apr 2025 10:12:28 -0700
From: Kees Cook <kees@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Alejandro Colomar <alx@kernel.org>, Alex Elder <elder@riscstar.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Alex Elder <elder@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Increase length of device names
Message-ID: <202504070957.A97CCC289B@keescook>
References: <20250310222424.work.107-kees@kernel.org>
 <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
 <y5hkfx6tld2khsv2rb7w3k5hlkhfjfn7ndwwj5g75hkdebvjat@mypbmvg5brfi>
 <alpine.DEB.2.21.2504021652130.53907@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2504021652130.53907@angie.orcam.me.uk>

On Thu, Apr 03, 2025 at 12:23:31AM +0100, Maciej W. Rozycki wrote:
> On Sat, 15 Mar 2025, Alejandro Colomar wrote:
> 
> > > > GCC 15's -Wunterminated-string-initialization warned about truncated
> > > > name strings. Instead of marking them with the "nonstring" attribute[1],
> > > > increase their length to correctly include enough space for the
> > > > terminating NUL character, as they are used with %s format specifiers.
> > 
> > It might be interesting to mention where they are used with %s.
> 
>  Indeed.  I seem to be missing something here as I can't see an issue in 
> reality:
> 
> # cat /proc/ioports | sed -n '/EISA/,$p'
> 0c80-0c83 : 486EI EISA System Board
> 5000-50ff : DEC FDDIcontroller/EISA Adapter
>   5000-503f : defxx
>   5040-5043 : defxx
> 5400-54ff : DEC FDDIcontroller/EISA Adapter
> 5800-58ff : DEC FDDIcontroller/EISA Adapter
> 5c00-5cff : DEC FDDIcontroller/EISA Adapter
>   5c80-5cbf : defxx
> 6000-60ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
> 6400-64ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
> 6800-68ff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
> 6c00-6cff : Network Peripherals NP-EISA-3E Enhanced FDDI Inte
> 8000-80ff : 3Com 3C509-Combo Network Adapter
>   8000-800f : 3c579-eisa
> 8400-84ff : 3Com 3C509-Combo Network Adapter
> 8800-88ff : 3Com 3C509-Combo Network Adapter
> 8c00-8cff : 3Com 3C509-Combo Network Adapter
> # 
> 
> nor why incrementing the length specifically to 51 (where eisa.ids names 
> are up to 73 characters; one of the longer entries can be seen truncated 
> above) is going to change anything here.  Overall since the string length 
> is fixed I'd expect just using `%.50s' instead.

These are produced from:

        seq_printf(m, "%*s%0*llx-%0*llx : %s\n", ..., r->name);

which is struct resource::name, which is unbounded.

> 
> > > For what it's worth, it looks fine to me.
> > 
> > LGTM too.  Assuming that changing the size of the arrays doesn't break
> > something else, it looks good.
> 
>  ISTM increasing to 74 instead might make more sense (I don't know what 
> the actual maximum size was according to the ECU standard, but it might 

The only mention of names I could find in the EISA spec just says,
"The NAME field contains text that describes the board. The MFR field
contains the full name of the board manufacturer." This is in the
configuration files, though, so it seems unbounded.

I suspect the right choice is to use eisa.ids as the length guide, as
you suggest.

> not be that we'll ever add any new entries to our list), once the origin 
> of the problem is known, though I think we need to evaluate what effect 
> such a change will have on the size of the compiled kernel.

I also see this hard limit of 50 in the Makefile:

# Ugly hack to get DEVICE_NAME_SIZE value...
DEVICE_NAME_SIZE = 50

$(obj)/eisa-bus.o: $(obj)/devlist.h

quiet_cmd_eisaid = GEN     $@
      cmd_eisaid = sed -e '/^\#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^"]\{1,$(DEVICE_NAME_SIZE)\}\).*"/EISA_DEVINFO ("\1", "\2"),/' $< > $@

The 50 was chosen seemingly at random in commit ca52a49846f1 ("driver
core: remove DEVICE_NAME_SIZE define").

I think that limit can be removed entirely.

-- 
Kees Cook
