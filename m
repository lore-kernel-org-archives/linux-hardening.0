Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E540149E
	for <linux-hardening@vger.kernel.org>; Mon,  2 Mar 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464487; cv=none; b=D7TYsQtItDHINXnNIYiJhOjm4vcVEBzpxTwFrz8RWDh7/chEp7/nJrvrJj2mFi+Yze9Ei9T3n8fkEH+Ruq3tMhKgbSRRthR/flUTEfOf6W8JYCRoK9YA4oh2+U1OLYddnvCb+7WC0XSmEHk2ChkT42gINlXgnkV7qvWtl+t7XXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464487; c=relaxed/simple;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hAN6espVDW8sOUhmnmemMqSx0NohqEjSfu5LZKHvNaS+EfkA8hYz+1HZTPbE4pNdG/5abTRJyVkojkaKT7cFOSQEAwWkP7C9h3WwVcAxyPeumS4roufIXki8RWWQKpF5TtBie0rjlIQ/hZoUwUU/LUTHO/A9IAMNsLQqOyBNZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=fail smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=omANQZWH; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="omANQZWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772464470; x=1772723670;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=omANQZWHMz/ySb7B5ONLBOqKUKShhEO6YY9Berz99FU+Lhcz4S0kjpEmbLqqWEjuX
	 wGoF/GW3VljMIt+CHBE+SyLurL3gHRwbRSTTbabrnB9kB9qrMS975YKd4XQRE/wDaW
	 UVAGcIM9NVGbWPVfVNP5qWNH+SXQOi0BtALOIO3vrBHJtsalrFUZKfauqs8T54Af2L
	 I9SC3GlAuGMdYowSAOEiABsfeC8V/hX38fKrKsC8vCzN6l81CqMz5O177TIkZBxsKO
	 9lhD1b0MJg/5AeVfasvZwU/Yf0dROB1uDSYSIv5CTNl14AnGsUiLelo3m9AKAfqLN3
	 7I0mSZRzC3pZA==
Date: Mon, 02 Mar 2026 15:14:27 +0000
To: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <ceotdtem@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Government hackers changed my video title in my primary / main / master Youtube account recently
Message-ID: <ZeGiDLy5-ed2qqgZAV4Br-J9zs0sXUEsZahfeFNt-OMcmqr6AXGvp8IQUcICKg0JQoBvMS5D1iq3QjPEHvMi0tOqIx_uh-nBnFMjfV71nPk=@protonmail.com>
Feedback-ID: 165137334:user:proton
X-Pm-Message-ID: cc23de877a8cd167625e09a37b816d9af8309059
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Government hackers changed my video title in my primary / main / m=
aster Youtube account recently

Good day from Singapore,

My primary / main / master YouTube account is protected by two-factor secon=
d-factor authentication aka 2FA MFA. Yet government hackers were able to ch=
ange the title of my YouTube video easily.

My Youtube video title will usually match the video filename on my computer=
, 99.9% of the time.

On 4 Feb 2026 Wednesday, I had uploaded a video to Youtube.

The video filename on my computer is:

=E9=83=91=E5=B7=A7=E5=84=BF Jayner Teh Getai Performance 4 Feb 2026 Wednesd=
ay.mp4

However, a few days later, I noticed that my YouTube video title appeared t=
o have changed.

Government hackers had changed my Youtube video title to:

Jayner Teh Getai Performance, February 4, 2026, Wednesday

Yesterday 28 Feb 2026 Saturday at 6.14 PM, I made a verification check.

The Youtube video title does not match the video filename on my computer. I=
ndeed!

Immediately I know government hackers must have changed my Youtube video ti=
tle.

For the past 19 years since 2007, I know government hackers have control ov=
er my Android (Linux) phones, laptops, desktop computers, servers, and onli=
ne accounts.

This is because government hackers regularly love to purposely and delibera=
tely show off they can hack into my devices and accounts for the past 19 ye=
ars.

Recently, government hackers purposely and deliberately show off they are a=
ble to change my Youtube video title, when my primary / main / master Youtu=
be account is protected by 2FA MFA.

What are the motives and objectives of the government hackers in repeatedly=
 and regularly showing me they have access to my devices and accounts, purp=
osely and deliberately?

Government hackers could have chosen NOT to let me know they have hacked in=
to my devices and accounts for the past 19 years. They could have done it s=
ilently and stealthily. Why are they doing it so obviously?

Why? Is it to distract me from something else?

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical/Mental Problems/Poverty
1st March 2026 Sunday 10.31 PM Singapore Time

PS. A few minutes after making the above report, my vivo X100 Pro 5G Androi=
d (Linux) smartphone started playing music by itself without me doing anyth=
ing.



