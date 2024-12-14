Received: from greenhill.hpalace.com (greenhill.hpalace.com [192.155.80.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFE17BD6;
	Sat, 14 Dec 2024 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.80.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734153841; cv=none; b=TqOqT3icxSXk0x3lGMWZ5ZnQYlEK3qfBM+sQ/SFGt2TR1eSXDiLrDhV6Bknp8nhVBJwrQ0b79K8xMM4+iGrGIyqIxgXfDNi9CZmtFKhr9nlbjeWKzjOOhjpkIv7LOTVm7x423W44pREt0XmAEttSzaYx9KjcoWXtaV9XVQTOdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734153841; c=relaxed/simple;
	bh=v2yvm1rDNTDsnU0ukvvGBmvRWu+hdWo+7RFzBTG623s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XSoCTpu0FwDAWXAtXkSVB1euCMVLwEfhUgT1WC8nDGvJR4goumzI3wSDh8tBzXgyw92dRN0zuveIc3oZ6r/oWkpR4YHZpVuebQcrqF+M63zBbzx1uXx/ggoJa0SgP7Bry3+ArAenrSc52fn+nwaiJ5Un0A0u64K4E62yDNFwww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org; spf=pass smtp.mailfrom=finder.org; dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b=WJOo9G0y; arc=none smtp.client-ip=192.155.80.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finder.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b="WJOo9G0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finder.org; s=2018;
	t=1734153234; bh=v2yvm1rDNTDsnU0ukvvGBmvRWu+hdWo+7RFzBTG623s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJOo9G0yxG9LYEHRUfwPFOPvT8fpoqYT9uExMj+qJ9j7l4tcUwYv5N1Sx6xpllNtH
	 h1rTQwhGiJrCtFAgrbWe3NH/B0CoRTEXAfGDGeg+FpWaYTjCWA2G/b1EOttyWaYJSu
	 LOYIjfVar9QiJujf0fJS/RMBqnhp2Gm1AOxltpjoD8ac87INKY8cumJuZWY1bxoOIW
	 7+Q7czvFKft32zTgIVCOhkdZX1XbCmF067WAXYHNcnoTWtvamEivRM2FBYSz/yr1dX
	 BeLUZFZH6RCKsropfJFIEUBaL5lrWU6owf6YzXj+9Z4/020vy7Eoq6G6Fcy3dF/475
	 9Mp1CZHTeEMHg==
Received: from mail.finder.org (unknown [192.155.80.58])
	by greenhill.hpalace.com (Postfix) with ESMTPSA id 7BF721842;
	Sat, 14 Dec 2024 05:13:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 21:13:54 -0800
From: Jared Finder <jared@finder.org>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>, =?UTF-8?Q?Hanno_B=C3=B6ck?=
 <hanno@hboeck.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
 regressions@lists.linux.dev, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
In-Reply-To: <Z08QvvfLSWGIDfBD@google.com>
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
 <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
 <Z08NV4Z-L0anDxGk@google.com> <Z08QvvfLSWGIDfBD@google.com>
Message-ID: <ca2a101ccf5ae790dd2cac58ff832922@finder.org>
X-Sender: jared@finder.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-03 06:07, Günther Noack wrote:
> On Tue, Dec 03, 2024 at 02:53:27PM +0100, Günther Noack wrote:
>> Hanno, you are the original author of this patch and you have done a 
>> more
>> detailed analysis on the TIOCLINUX problems than me -- do you agree 
>> that this
>> weakened check would still be sufficient to protect against the 
>> TIOCLINUX
>> problems?  (Or in other words, if we permitted TIOCL_SELPOINTER, 
>> TIOCL_SELCLEAR
>> and TIOCL_SELMOUSEREPORT for non-CAP_SYS_ADMIN processes, would you 
>> still see a
>> way to misuse that functionality?)
> 
> P.S.: For reference, some more detailed reasoning why I think that that 
> proposal
> would be OK:
> 
> It would protect at least against the "minittyjack.c" example that was 
> attached
> to https://www.openwall.com/lists/oss-security/2023/03/14/3
> 
> The trick used there was:
> 
> * ioctl() with TIOCLINUX with TIOCL_SETSEL with TIOCL_SELLINE,
>   to make a selection (a.k.a. changing the contents of vc_sel)
> * ioctl() with TIOCLINUX and TIOCL_PASTESEL to paste the selection.
>   (The implementation for that is in selection.c/paste_selection()
>   and is just copying from vc_sel.)
> 
> So as long as we are protecting the change to vc_sel, that should be OK 
> in my
> mind.

It's been silent for about a week and a half here. How long do we wait 
before creating a patch here? This is a regression so I'm assuming we 
shouldn't wait too long.

I'm happy to create the patch if that's helpful. I'd need help with 
process for submitting it for inclusion in the latest kernel as well as 
backports to earlier impacted versions. I've never submitted code to 
Linux before.

   -- MJF
