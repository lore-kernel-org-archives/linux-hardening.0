Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABE39CD0C;
	Thu,  8 Oct 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477674; cv=none; b=RIXWfnwDbc7koA07oMgTbT0ojmfSJhhc/txS1yvJ7TsrdqKBecwr6+cJoxWRlcvNiPjiYOAOb7fdRFP+SM071iLjyrzFT7OPqf40hO+DaPwj8qRK21fdv2MZLh0EEL/EMhKjWI5YdQSerktLwuqxpKDVvfAzyBiZ3tVBKsWvRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477674; c=relaxed/simple;
	bh=gb0WsiZhhHvYTv0DyD8MX/eH/RRxnQYOHtPCH1VAqd4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YEUI2Fj4u63acMwro1sIRy4a2/mISQic0PYKjXu0P4auCpR+ftaA4k2WGJ1QRTDGydCy0X1eXwDDU2jxhzKD124wg9ouhDr/pw1EXrIH4lv9wU8I3TX5GITvBrfppP7/5ZCaU/SUY8wr1y0S51mOWmoq21BhttFNfmqmndxIPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9NHgyIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9NHgyIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BDD1F000FF;
	Thu,  8 Oct 2026 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477668;
	bh=SZsmK4vppoHWtoqpg/gnMTdL025sRiF1Xq2a4/OeFOA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=h9NHgyILYUDSHkbe+fAQDEV0R+HZrfx1eWudhbBU1+2ZZueY9geCc+riWoSzQDTor
	 xIedZPuI1ViGj6xpxQqhIxHNrJ8cLCcCO1sNqk/N2MoHBM3UEuSD/0nQ+yzDLsBXqg
	 slLIBIkMSbxrtJq/0CBZF0WHt0Voc4MheWlLNrxzAwi4GjVy6q5UDG6CecefAP9Att
	 cPSEudsaUPICR8t5mvkrj53cBd4oDRFhR1dcZNi8jUpdO3eSiFfZvJhtuZGFHxv7oT
	 eHx3IGR5HxIiKH9Wzm3N14MKL1NKSJEsjAQSmN6Kq3IfvuU53LlWuLWYEA/Y7OVN8u
	 H+q51YTgk872A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 1F7E0198003A;
	Thu,  8 Oct 2026 12:41:06 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 08 Oct 2026 12:41:06 -0400
X-ME-Sender: <xms:n8fHau1JvBbOAzvD1mRGlf2KAmiUg-E8VDBtyIVJsbvu3MEiQE02zg>
    <xme:n8fHar47oWBPAwgiRt-1fdalDHXuuiJpaIQ0Z79G_DRgXk9_RTlzr1s5g71hebuYZ
    dtj1_Hj8ryaH-QcIIhVQPJTvYGTd8dNsAjS2JJc5bh1JtFT5N_i3Fs>
X-ME-Proxy-Cause: dmFkZTEzFzB1wU7+qeMo+i+/axzQl+PUr2Jn75vjM4R/6QmGMltUQzY02zaHilTvbtCWyA
    DgsIbJ9j4lJ2UgsU7UiqjQSpjJ6+Cevu3eoMakV2uyopDtEPYGxqUTo+suMUMyXSmHt9D1
    qVYpNMbEVNUJjE92NlooqbwaVpraQ+JODZtwSt44/pr/DD/DZ9cHJ2LrkjXp16a/yZNG4J
    fQ8EdMHBJELI9Zok8m6wj0pUDWg9ppRmN7lTLEhcHCBBKxBhffLye2SH2M+xlRCVoTc9gA
    YlM7m7ozENg1yUXpC3mZnQZElqr27PD+mapnbsFl29Zt9SJ8hT+tXG+mODftbmRJNb32Ai
    bn6f2Fa7lKJaaqGh4NSy0usWIJZMMHY04Ba7RPrR+ul69aMV1aSuR/5mZ+YYO9edPyPSG5
    5GBl5TbJBf+Dzurifxw/+Wk+SHfFq+TrYRc7pB1C8wODqS/BGgJozTbvIafup0OUiscMoQ
    n3diM1klL2Xl+m9+c2Alr4baWVVjEKT7nT0qyti0y27YC+q/jTyqqKPsss7Q36SiONIkzo
    sv3d+znPhIwDifnJyxHlx5N4kky8nArjIJjbR7bL4Yhmb+SYLEbGSMRAfU1Zp5HnypCSGA
    pnqJKKZxiB5FDhdpK+PVaCoLW5ATxqujmXI4hWe+ZZ6rdR522T8P7LAWkcug
X-ME-Proxy: <xmx:osfHaulT3KOMGe5g1r6WlHV0oiPPnCx_x9vLj3p6ru0htQcJzxhAzA>
    <xmx:osfHagMlNKifIUrEJLe3cfWLvDac1k7zn1NAHQRGfrAmSdF_huBJ5w>
    <xmx:osfHaiwU_9x6AzEhmlRAUoqMYgq5WWG5q3uK-QkTB9xhzO5oKkI5og>
    <xmx:osfHattCsiA8hFP_a9yY6uPbAnZUCpvQMT8yhYuUfFSNkBUMMjiELA>
    <xmx:osfHalY-BjQKI9OaL6kpiXbzodST32DOyXdjG-UhXFUDlsaMr11rfCBH>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5C462F8008E; Thu,  8 Oct 2026 12:41:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 18:40:42 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Bill Wendling" <morbo@google.com>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Mark Brown" <broonie@kernel.org>,
 "Marco Elver" <elver@google.com>, alan.maguire@oracle.com,
 namjain@linux.microsoft.com, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <eb644465-0c41-431c-85a3-f7eb6bd86cf3@app.fastmail.com>
In-Reply-To: <20261008161724.GA459@ax162>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com> <202610060642.7C4125F@keescook>
 <20261007090915.GA1504630@ax162>
 <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
 <20261007093641.GA1527653@ax162>
 <bc2e2ae7-02e7-4148-8ad2-ab3c1af3dd7a@app.fastmail.com>
 <20261008161724.GA459@ax162>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, 8 Oct 2026, at 18:17, Nathan Chancellor wrote:
> On Thu, Oct 08, 2026 at 04:50:44PM +0200, Ard Biesheuvel wrote:
>> On Wed, 7 Oct 2026, at 11:36, Nathan Chancellor wrote:
>> > On Wed, Oct 07, 2026 at 02:32:45AM -0700, Bill Wendling wrote:
>> >> Ard,
>> >> 
>> >> What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
>> >> there something that breaks things?
>> >
>> > I think it is mostly historical. See Kees's series to address it:
>> >
>> >   https://lore.kernel.org/20261006204210.i.137-kees@kernel.org/
>> >
>> 
>> I've queued that up now in the EFI tree.
>> 
>> Do we still need this patch then?
>
> I don't think so, since the efistub should now get
> '-fexperimental-late-parse-attributes' from the main KBUILD_CFLAGS,
> which is what prompted this patch in the first place:
>
>   
> https://lore.kernel.org/CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com/
>
> As I mentioned up thread and to Kees in person, we should still consider
> adding '-fexperimental-late-parse-attributes' into CC_FLAGS_DIALECT to
> cover other areas that may see __counted_by_ptr use but it is probably
> not as high priority.
>

Excellent.
