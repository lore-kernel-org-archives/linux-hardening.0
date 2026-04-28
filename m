Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF231AF07
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408070; cv=pass; b=fll6aan2kb2IwgSA/NbMQsv629gGK6FLt7aLQ16Z8LBMceMiCn3Rsixx+mLBc7WBFn7tfJbh7j81FMLV2p+GTc2Z0qb8phL5rvjONQJJU2WBb/ZabBogmqcg3M9Kc7NomWWUmpHoGdHVjm7NxR+5Oaujr62NurprZswEnNTWuz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408070; c=relaxed/simple;
	bh=8pZqDLVXGdKS4vEGYY/DHdErCtozb81IbFmeZdDnZOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMKR6dL47dKRJaGqbM7WLXq9/HGocUE5n/bZxK6MI+wq38Lt7xpub3rsB8ztgT6Jfpq2JTw06fyIwipTfAPyhrvJ2z8C7KMjiXvyRmaoizUf85WgPQA8iR0sFq3u/idZVL1RBq++TKg0H3KUTm/IUXYUB8go6YuPmnOZcHz+Lgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYgXDGyj; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYgXDGyj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso13269588a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 13:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777408067; cv=none;
        d=google.com; s=arc-20240605;
        b=UFC2UGC4TvEZrth3jzTmv/mMmrrz8NmOoWfKdgdt5tYdt6iwx5MVlQ3f7uVQH/eVU7
         HmiJKHZrGIkl8N0cnn8l/qQB3d9OHKN/jKOGBSUU1VYUS68DFSol2NfMOj5wTB5Zu5cG
         luaA/XEE5jqknGjQ6vqWCrqaIDtf4xQxcwFqqESdtcQXTFRTGwAU/za7R3upNIzLEGFs
         kQxbXRMGjknbDUnWbPm8DWHdTXRidZqVcoaW+01TIyrfKitgavNbTp5TGkrpjZUZeniy
         uuaGqwI+BpCAv3gKR8CijKCoyam3oKZt4rgGxFU71iis9GcTjjHLBRWVDt5J0+BvJi04
         Iu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        fh=VAhV/GXhC5CPvDkKH23NLJCM8mqgVzkORKcVElaRFGU=;
        b=VJ5JdpyCn4u1Wq9uyr4P9rgoDjhEFt/J08AuFgKGMLWIenw44wqpN/x7PNmlbWa68E
         r8r8u9WVKKA+OHsfSuvI3eleSpmkJ6aecBBQakuj1v83IldJQA9EWYZhKw3ztabX4ECO
         mH6fobvZqmN8iB9cce4pGyeUP/sYyEgT4xKiyTQq8/KH16C/7D5fK3JouwVdhWTWnTki
         X7ERzyBDDUtynmiZyUTwXL6tbl/5ePhxqy/5yoZMVDXIeD58TGMEhCuhGBBWh0hbXNCQ
         8NaRVq2By1kaVa3vDjwBtOKFwQqs24Ro+txzNx7aleQNNhu7PniBiFZz3B+wb03+9cg2
         LY8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777408067; x=1778012867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        b=bYgXDGyjWJZMsmVGWhGSIGIDyj+PqD7RHshfyw5CpKA7Bmpmd+5MiKTD6lCsFczOzT
         A+D/orHAHFm9JaklPGvS43eftIPkAWtL48QGRim2+VPFumuCfQTaD5m69qbC7tlGIHbe
         5I9l+DRten1uo+GqZjHoUSqIDo5DwOcTSL+2GsdSn6F088TZ4av5OSUw3RjEf2xKsZMk
         BY0+FZm/9pduSozg9lr4fH6MwuF/uuNFq45Xbx5gRj0rpI7CUB9IgQx7vH/zBBGOQqnh
         WZ2fxj298x1Lw231rn3OS8hwxWDw0gp+BYMXxw8B0ixV/fGf8UmogmROz53QftGYpKyM
         S8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777408067; x=1778012867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        b=jgQQLIRI71jpyyeZn2PjYUYJx5kTxXk9awtQewgUqx3TSXHikwepN2JTgUZd+eld1K
         qzabt8iSrcgFPv2JaKbcJThbKPajQ180j+HucGCLk+9Y7pN/e3RyNvrp1qajtDrFRclN
         0+g9BsBxVQCBk3laxka9eojJaCVlGme5oHw+WjYzY6/G9WaJXgSZliGvvA0NAirvGx0/
         dGYo5Kz2O+1IycNV6NmJQP0SZPwznCgwPX7r9oA7ss4eBGKCksZz76oNnZ5wbRs8MaHV
         WlrFwF3/MRR02lBnPChDabDTkE1lmfVOa9fFNydikqgB8V+A9WJsWA53ZRCf6EL53sq2
         zJyA==
X-Forwarded-Encrypted: i=1; AFNElJ+pPilA6fDVN9WLka3at9TDMxv3JZ88qv1Zd7FxyjcabAsdB3Vi8XDQzWksHHoxhVV9G/t2EV6jzH/9JwhtwTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfC9Y1kwYjzQkwbDqEl0mBjlgpN3FgMp8JsbCl8jwpcC5o7jFO
	2z12ev8GLRKSQNAy95Zlud174tTocLJArfqdvBPRnjwoQ9I5F4CAZ/ZyxUa7o41Q6hMkJNWzxVd
	LxqE6TqRrUmEeWt0FlxAgZU+LpMUwewg=
X-Gm-Gg: AeBDiesovLX8ksqzx53J1fsLFRnGsN4D/WShd0obOJOj96Q+Vkoukctk49t4mYV98fG
	7+FPCxy54n88oLJdGToobbNcKfS9IKOjUEMlWgFMmh856l95cTIz1xx41Ltpfkm0ho/uLqkbIEK
	VZX9Ygq8i/bq3XqcIlQ/GGzltQl+n61ikkAJYc92vvu1G2RrNbQMdYXbSDG3MIMotEeBoRsUQo3
	mKU/5kQjRhAQOLsBnmaN3qwk1d0fBa8Mt+5/wKx6Iz3fHjwsJgU2vyItHNuJSiw/Dg034m9YoJ6
	sMQ8KyCJLQA+bO19ZXI57WCrKTATXbV8si52x7b575s2Gluq2SrlDO5ukeyYInVdsuALZdJvzNI
	7tsRu6wiH7aC+gR8RrGcM6GIQtRmapbgoxz1jOWQu1eqTe7GxZuGB2832Wwo=
X-Received: by 2002:a05:6402:e94:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-679bb0982efmr2165877a12.19.1777408066633; Tue, 28 Apr 2026
 13:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172817.417614-3-thorsten.blum@linux.dev> <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
In-Reply-To: <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Apr 2026 13:27:34 -0700
X-Gm-Features: AVHnY4Jkk0RBV4cH1i-ipNNk5Jr5JuI7AhhHwp3PjTVZY3bKpVhsokcMSgzE7Yc
Message-ID: <CAKxU2N8OUcsTxG4XDH=cbROz4954-V5ximN-XHQ5RrPagTfUjQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: annotate i2c_atr_adap_desc->aliases with __counted_by_ptr
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:30=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Thorsten,
>
> +Cc Romain, author of the involved code
> +Cc Rosen, author of a similar patch elsewhere in i2c-atr [0]
>
> [0] https://lore.kernel.org/linux-i2c/20260327030310.8502-1-rosenp@gmail.=
com/
>
> On Mon Apr 27, 2026 at 7:28 PM CEST, Thorsten Blum wrote:
> > Add the __counted_by_ptr() compiler attribute to ->aliases to improve
> > bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  include/linux/i2c-atr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
> > index 2bb54dc87c8e..b52a7b9ec536 100644
> > --- a/include/linux/i2c-atr.h
> > +++ b/include/linux/i2c-atr.h
> > @@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
> >       struct device *parent;
> >       struct fwnode_handle *bus_handle;
> >       size_t num_aliases;
> > -     u16 *aliases;
> > +     u16 *aliases __counted_by_ptr(num_aliases);
>
> I'm not fully proficient about all counted_by things, but the patch looks
> OK to me, and definitely @num_aliases is the number of items @aliases mus=
t
> have, so:
I prefer my patch.

__counted_by is supported by more versions of GCC/Clang than __counted_by_p=
tr.
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
