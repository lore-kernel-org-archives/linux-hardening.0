Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2C27057D
	for <linux-hardening@vger.kernel.org>; Sun,  7 Jun 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821635; cv=none; b=XPUoV0w5Qp0LRTVUkxpCr28OEKbkIDG82mLpLM+SIfLfvcrdH6cLqMb+ttJqaqvX8tQAAmIxiqxFCslVEipxCOe6mGFN6ojabakJK0gG7+l9QkZmMZ+IODWCD4NlIAFwjuH8PrOi46IEvqtvHCW6QAMFayQa7z2BAODYHEl7hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821635; c=relaxed/simple;
	bh=z4rfpECDUd4+fp5V8mPcIWgEOMMN5fJNP5S4vnw9JZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlzId6iCntu0IFCKky7AUMe845mxzOAhm/RHcC3gRAeeH++TlG0y7uk+7p1BktTRWh5zuq06gCDTgfXL1C2bAr6Pn3mQXToqA2xKQSatlultxFGJ1++HLFrNb9xOE47nY7nn3kg3NGz36cAXFkUYlMqkOoigyw5hs3Q+LE7ANJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmejJxmj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmejJxmj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4602e2a0372so2215925f8f.3
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780821632; x=1781426432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw1xVuhJOQHbfyU6Yw8EFKK1j/gn1/vNa/UVGcPSkm0=;
        b=pmejJxmjJQVSWjPE32PPEmG9rBGizJfyA7rkEx+krkJnmAEfuCfGKZR2+Iwrx/K7z8
         fs7XNrZL+QVL0rGQ70IpR/rH5/dFFth3mTf5C7J2kPGxsYc8AIJ+0PX+USVJIVcF9XYz
         LhACWI+SQIOSgqndAMsy6RJSs8rc7MfOnONJt33b9eubWRUMa6er40QOpq5Q9URtzRjD
         NZYjfxWMoIcI9utncep3/EC55vTjYfSRB/D5rfolOw0W7WhyjydH2AqWy5lcU2sIaQ3s
         afpVThSoLAplzbZQRSDQmVSzYlXkCPHSNVSZZuGhCydGGiAalUO/Xckvdlc+uqqVJOxt
         Rdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780821632; x=1781426432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vw1xVuhJOQHbfyU6Yw8EFKK1j/gn1/vNa/UVGcPSkm0=;
        b=VboglTALQmpOxvabWrKsLCEH5IfTGPlwi68ammgCkM8fNe/MlJuBwZWebqVKwSfZY1
         W0puGFEMS4BqGUWdDjFyOInalYGLLNlTCbarqpy1RXjJwnq2rbJAOaU7XRjVyn/TCbBz
         KwWQcE2WJ5Cq8gWQ+ZoepRv33bhLBPdDAKRiRakmrmNpQqTzC21R3XbYGgo3bWmd4aIJ
         PsTyc/+ttHi8GghVdeUd12G+0EvFooHZJrhCsAxDm7xEBR4vOdu1aNuddJIt3OhHFP+0
         twrL/19BGn3H8Q0aZkZIcZZrS0bmER4IMA48nHnfutqJvHmDHwizZGi/R2oQIqkuTpDN
         AeTg==
X-Forwarded-Encrypted: i=1; AFNElJ9pLv74zDPL6UGW2aDL7WK9A/jcbkHIINYVVzPM/QNIzCayMCsRJV71bfKpst/pbfruiy/aBHAVB9f/dsIJWUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/GEWcISKYwWS7yvfFDoGzZBAU2q7wLz78stErX6/z6PSwaqG
	s9+l36CSJvLHfRH/EYBvuBKTPBoQHHE6gQ3LwE0lWwDzxOUVHomTHAry
X-Gm-Gg: Acq92OGZdjdSBYAPotdU11R62pSoC7F4uSaYRAh3SjuF25kpzdrhTzQNK/R35hm169V
	obymBYMDJxtg1gUJ1/Es+Gg7m9muu7XZYuaeFy6xRK2/rob39yksEMcFpDJTfyizz2fGTGcDlYv
	u37JYZ38KBJqeulOHZ2amabZovJ4yiqpNacKUqKrEG1ti0EpShHo60yxV5ffrIIJChlVuY5mI3e
	XUWWtLRQf0xpmYHHIuir1FbIEhPsxRgdwm1goBtmP12qt7n6PqF7FTFLbotzhchEnQpYuWCgTm2
	dU/opxNuEBn5VMUJxqP2WU5coCTtMfXKDuhyVYnXeAVkTmdXZlADFqyMa8/Tjpx1vyDju1HirEd
	B74F/745smV68V7Eh3P3pGeb4SMrkkJDxarYJp9Rccl3DX0rzUnEg2ETjpWuObdTa6YYZ2pFm8M
	AcyhU2ZdXR1wxiHl8J71yvWxiINuWeWtGWd0naPQ4SxEg9Hiu9MTLECOwN3rCgbb73FsytEmI1g
	JvMyCa6nA==
X-Received: by 2002:adf:f911:0:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-460307625cbmr11917197f8f.34.1780821631657;
        Sun, 07 Jun 2026 01:40:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm42644235f8f.11.2026.06.07.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:40:31 -0700 (PDT)
Date: Sun, 7 Jun 2026 09:40:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy()
 to copy device name
Message-ID: <20260607094029.6ffd4eb0@pumpkin>
In-Reply-To: <f8848570-8793-4f5f-a2a4-ab212dcaebcd@kernel.org>
References: <20260606202633.5018-15-david.laight.linux@gmail.com>
	<f8848570-8793-4f5f-a2a4-ab212dcaebcd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jun 2026 23:16:47 +0200
Vincent Mailhol <mailhol@kernel.org> wrote:

> Subject [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy() to copy device name
>                                                          ^^^^
> Use?

I'd forgotten I needed to fix that typo before sending the emails.
git makes it hard to change the commit text itself.

> 
> On 06/06/2026 at 22:26, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)  
> 
> Indeed, this is terse. The commit body is empty (all your comments are
> below the --- cutter) and the subject line contains a typo.
> 
> I don't see why the fact that you are sending many fixes clears you
> from writing a proper commit message. And I would expect at least a
> small effort to customize the message: only explain the Makefile stuff
> for the patches which are touching a Makefile.

Try it!
I changed about 150 files to get allmodconfig to build.
I only send patches for 45 of them (otherwise I hit a 500 email/day limit).
The next 45 are 'pending' and some of the uncommited changes are less trivial.
Spend 10 minutes sorting out each commit message and it is another 16 hours.

A few (like this one) are very terse - then I realised I can send slightly
longer commit messages by typing a multi-line argument to -m.

-- David

> 
> >  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > index e09d663e362f..2cd58e825e0e 100644
> > --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > @@ -746,7 +746,7 @@ static int kvaser_usb_hydra_map_channel(struct kvaser_usb *dev, u16 transid,
> >  	if (!cmd)
> >  		return -ENOMEM;
> >  
> > -	strcpy(cmd->map_ch_req.name, name);
> > +	strscpy(cmd->map_ch_req.name, name);
> >  	cmd->header.cmd_no = CMD_MAP_CHANNEL_REQ;
> >  	kvaser_usb_hydra_set_cmd_dest_he
> >  				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ROUTER);  
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 

