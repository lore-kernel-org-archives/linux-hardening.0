Received: from zucker.schokokeks.org (zucker.schokokeks.org [178.63.68.96])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6A148314;
	Tue, 17 Dec 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.68.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425862; cv=none; b=sxPKPMKi9zfyKn5TTSXG34BoPo2ZAIuZFfuugqBf0tNyOXJgz2qTflVQmpB0vx2VJtz21Sv8yHmCjzMORj3RoRfeE7z95gmlMm0qbBl03SADThqBCHbq2Rw/rn2VaqJHBMo/OlOV859hLHw7fl7LPM1hKB6cyW3Rqx5zxj288Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425862; c=relaxed/simple;
	bh=cFPC9eZTGmTGQ5JYIGpHHiYSjA96PitwDXdZwb5mEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtO47lCwBJDm0+YhWRM8mpUOZ+j4uaq512DBRYWarfM/H32l2pvh61Oi25WyuFh4Xdf/16KxUefm6cJF7Nx3iCK4cUYPuTY3cMrnj9CpP6AsxOSYHeEPCuEdUzBTrtnSiWm51fApEw5HxDph85emo3IZ6q1C9/qmoTuME6SpBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hboeck.de; spf=pass smtp.mailfrom=hboeck.de; dkim=pass (2048-bit key) header.d=hboeck.de header.i=@hboeck.de header.b=ZWfR08cj; arc=none smtp.client-ip=178.63.68.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hboeck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hboeck.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hboeck.de header.i=@hboeck.de header.b="ZWfR08cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
	t=1734425245; bh=vNbejaey0PFZXJP01vfrvUYU/N7gtFS3a+6O154KDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ZWfR08cj5RrKR2bh4u4SyrAXI6HZ4T6bKxDO55WmVSLRvAS4+Xy4Wza/pyzQMF9FX
	 mmWzkPmaID93clBxpPR+FGmCYARW/Yj4y+7Hj+9Q3Vqay8bMrOzW9XK4WO6t+CNSNl
	 vCapde+Jdp92PtHN/lwJ+fT97+KFQWxlma4ax7ZU9ztQInDXop72uXP/oiBcrDrOA2
	 /xnTO21Aq4VhWCIGLm44qdIe+X4miq0OFo3G7d28zWhXoHgkRGWCggLByjfRqsZbwX
	 nqZcYXyWbprc8L7dfLtDKMn5CyOmNHmDey2XFYgZT7KasbUXTtp7ju+qzTNWd9N72/
	 ATzKISa6voSXw==
Original-Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
Author: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Original-Cc: Jann Horn <jannh@google.com>, Jared Finder <jared@finder.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
 regressions@lists.linux.dev, kernel list <linux-kernel@vger.kernel.org>,
 jwilk@jwilk.net
Date: Tue, 17 Dec 2024 09:47:23 +0100
From: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
To: "=?UTF-8?B?R8O8bnRoZXI=?= Noack" <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>, Jared Finder <jared@finder.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
  regressions@lists.linux.dev,
  kernel list <linux-kernel@vger.kernel.org>, jwilk@jwilk.net
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
Message-ID: <20241217094723.57c7cb1c.hanno@hboeck.de>
In-Reply-To: <Z08NV4Z-L0anDxGk@google.com>
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
	<CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
	<Z08NV4Z-L0anDxGk@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, 3 Dec 2024 14:53:27 +0100
"G=C3=BCnther Noack" <gnoack@google.com> wrote:

> Hanno, you are the original author of this patch and you have done a
> more detailed analysis on the TIOCLINUX problems than me -- do you
> agree that this weakened check would still be sufficient to protect
> against the TIOCLINUX problems?  (Or in other words, if we permitted
> TIOCL_SELPOINTER, TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT for
> non-CAP_SYS_ADMIN processes, would you still see a way to misuse that
> functionality?)

Sorry for the late feedback.

I believe that this is correct, and permitting these functionalities
still preserves the security fix. I also checked with Jakub Wilk, who
was the original author of the exploit.
The patch you posted in the meantime[1] should be fine.

https://lore.kernel.org/linux-hardening/Z2BKetPygDM36X-X@google.com/T/#u

--=20
Hanno B=C3=B6ck
https://hboeck.de/
