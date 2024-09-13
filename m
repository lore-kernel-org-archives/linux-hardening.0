Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535273478;
	Fri, 13 Sep 2024 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202910; cv=none; b=VQqEkExhjxvKFYTX+T2TQFIAqy4dMA8gkuoUwBBKlgszlozXyz/OuXP32gAALh9khkA4SBTj436C95f0qKVXfRf1nf3GlWO3jVhCxcXbJXqVDDTgWy15eT21bDmMmgxeCYMrQOhJ50VCMS30FmRt8UuHVf4X4H7M1QIgYkelZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202910; c=relaxed/simple;
	bh=Sz03wy5XM9QLVWqoY1wXQrvfZ2ge3cQGNxb4DSSkEnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U950XDk+Xbwl6AhEzmBv0UzOYH8bzZuugs4PayNxHGw+aNaWvurtUSiZVl0F98HuJBPjWjiygoOroedD7u4ph26vn+obGW0Y5cNjSRUh09BHJEgpAgz9JJJRLIv/OiLWW6PP6NjLl07gr9lEPufVln5bTWiXKKuEqxcewzw2p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz+u3P2j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz+u3P2j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-205659dc63aso18426885ad.1;
        Thu, 12 Sep 2024 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726202908; x=1726807708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKtjluajK1eu+gMy/vDthl00olkvEut57souYbQ2fBw=;
        b=Iz+u3P2jOHBj3Sx/ZoGDV4B6DAla93VO66JkjyCkdZadHYhBAlCP27CFCF/4rVW8AI
         UHBF8QrIzud0oN0d6ispNqbAW+ON/9ybZOOeFZZ8KIK6pEc6vTTQWWfb4sqoLtiSArU6
         j2FKklF0H7K6T8EpJHR+FlxZssrJgCij3aMD/RyE+eKqYPck1BFd6OXyDsA8TB8RQc1K
         yNq7VzXm+Ejp8nmkDDE9ogEDo95WcWyj08lvGVCCvRP8XfL/dqgfaCyUKGN+FaGWthPm
         oMiUjOuP3fmEJewGtQV9cgD6hPSp8/wm+uMU5ZKSQVG34m7WGQXoAU3E0Q4TzAf8W01z
         x8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726202908; x=1726807708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKtjluajK1eu+gMy/vDthl00olkvEut57souYbQ2fBw=;
        b=rO7Uhg2RgR1Kh6So3hkBr/U4IWrf8xiuppNd1lDcHwyLNJ1OM8Tvke85CmwHRiRYHA
         3vD/N4IJMxixo7dZ8pyJsZFSCvZABqI5oXhJh/j4H+884TowaF+tMt2MAycC51jLUbu+
         PRl1nJ8g2eGucG/fFBbPkdvesrWTZbScRRiY/+5uT2M/hpz1E/leTv/IdDBdkGo1jg7/
         PrLAJ1YXL06x00QRJj6DYJNjUzLb5z1/m3490FI4SNUKtH2wnLtgKqTioF5E1q8MaYhK
         XbrvwdIouwcUtJI6bYKM2FYpbEPe+vvaEsOQpWtq+g9P4w7K+9hs9arZ02hAomZy50jL
         G8bA==
X-Forwarded-Encrypted: i=1; AJvYcCUa9bvEwDKIB46fCedwNWtkyRQAOCzwggg/dD3diUojM8UyNDXhnOaMgPQwT+btxqK31eMEdRVrp5zt01Qn@vger.kernel.org, AJvYcCWrHGqXwO+9Qp+fOvxCL2CWLtvqPg7cj2E+gkvPTNq/p/uYZ+ROVy/9Zmby/ryzpjQsBrBjvn5PgS07TUwPJTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+AyL7ebikODS5nQt/BIU1ERPNInENZ4OL46m0pY0o5bdw5dA
	vsLwc+M1+Pkj4z1dokTR3A09ZpVvWIQRRbC+331Kunn/wvR6McfSG5ZqVQ==
X-Google-Smtp-Source: AGHT+IHq6Oy9NXtzQ84sCUs02FuV7fWkXwrrWP8ocRcr1mNCVjcfn3prlitU07KMiXbOF5WMJV5k6w==
X-Received: by 2002:a17:902:dad0:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-2076e462c42mr73795675ad.41.1726202907969;
        Thu, 12 Sep 2024 21:48:27 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd025sm21190195ad.162.2024.09.12.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 21:48:27 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: David Laight <David.Laight@aculab.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] overflow: optimize struct_size() calculation
Date: Fri, 13 Sep 2024 13:45:19 +0900
Message-Id: <20240913044519.1875252-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <43ac488d0a83486ca6d969643c7b531d@AcuMS.aculab.com>
References: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr> <01aa8bd408d04031941073b026f171fb@AcuMS.aculab.com> <CAMZ6Rq+6EKoFEHMZhp_2dq2DPEP6zZgzDy0M3tegKK9wOphA6g@mail.gmail.com> <43ac488d0a83486ca6d969643c7b531d@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[resend] I do not know why but below message got blocked for, I quote:

  Your message looked spammy to us. Please check
  https://subspace.kernel.org/etiquette.html and resend.

And I have no clue which part I violated. Maybe it is the gmail web
client? Resending with the git client, hoping this time it will work.

On Tue. 12 sept. 2024 at 01:46, David Laight <David.Laight@aculab.com> wrote:
> ...
> > > [1] Both the '+' and '*' have extra code to detect overflow and return
> > >   a 'big' value that will cause kmalloc() to return NULL.
> > > I've not looked at the generated code but it is likely to be horrid
> > >   (especially the check for multiply overflowing).
> > > In this case there are enough constants that the alternative check:
> > >         if (count > (MAX_SIZE - sizeof (*s)) / sizeof (s->member))
> > >                 size = MAX_SIZE;
> > >         else
> > >                 size = sizeof (*s) + count * sizeof (s->member);
> > > is fine and only has one conditional in it.
> > > In some cases the compiler may already know that the count is small enough.
> >
> > Indeed. If count is small enough, the code isn't that horrid. If I
> > take this example:
> >
> >   size_t foo(u32 count)
> >   {
> >           return struct_size_t(struct s, fam, count);
> >   }
> >
> > I got this code:
>
> What happens if the flex-array is larger than 1 byte - so a multiply is needed.
> Probably worth testing something that isn't a power of 2.
> Also check 32bit archs -godbolt can help.

Here it is:

  https://godbolt.org/z/dKdvW631e

The original is on the right, my patch v2 is on the left. I did not
add the optimization of only doing the max() if sizeof(struct) !=
offsetof().

It always takes time to copy the macros and make them work in godbolt,
so I was just a bit lazy in my previous message.

If the fam not being a power of 2 does not change things so much. At
the end, it is just a problem whether:

  sizeofof(*s) + sizeof(*s->fam) * type_max(count)

wraps around or not.

Of course, there are a few cases in which the multiplication will not
warp, but only the addition will. This always occurs when the fam
element is one byte and the element count has the same type width as
size_t, but it could also happen on degenerated cases as illustrated
in warp_only_on_add_fam32() (I can not think of a more realistic
example).

I will do a few more tests and maybe come up with a v3 depending on
what I found.

>         David
>
> >
> >   0000000000000010 <foo>:
> >     10:   f3 0f 1e fa             endbr64
> >     14:   89 f8                   mov    %edi,%eax
> >     16:   48 83 c0 10             add    $0x10,%rax
> >     1a:   e9 00 00 00 00          jmp    1f <foo+0xf>
>
> Add -d to objdump to get the relocation printed.

What I previously posted was the result of:

  objdump -d foo.o

> (I think this is a build where 'ret' isn't allowed :-)

I just did a defconfig build. I rarely try to tweak this part of the
config. Now that I did the gobolt, I will not investigate more on the
config.


Yours sincerely,
Vincent Mailhol
