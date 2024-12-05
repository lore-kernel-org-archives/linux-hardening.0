Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387617E473
	for <linux-hardening@vger.kernel.org>; Thu,  5 Dec 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417393; cv=none; b=ThrkAgqWOAcmaiOglzxmCW1ed64Sjvn8qySYMz8K3V9HB/G53Q4e6t9z1iH/vofNV7ErivLuSx5r59WmJ7sD9QtObaAtdu/F350MWHZ6qkkytcZioFl4inzKDBteyk0F9tR2OXQ8Bnlh2RwgOkcPhQkrhAXlyukjp6PWYoA2TTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417393; c=relaxed/simple;
	bh=wvcGp5YJl0HfkWrsMAG+o9ANiEZLKm9ke1EVz3mOeN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQyNcRNputjP0F+jF8fYPT2dThZfwKV00252nMtu3vnEIapUxb0g2GJYFSAXh9lidDUfMRGzntiMHeaKSNy5iD6cEZRdl1M8+yAo4DdCH7hGipZ2u/0LEbvUkxlmdzAu5JwFLEc9bQ5fI33pxaCEAs5OCfeyZiO/PczGvkU2HsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuU1ZM0b; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuU1ZM0b"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7259a26ad10so951885b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 08:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733417392; x=1734022192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LW3nVyGBjPmC7MmiF6/pZIPadVScmOhCq1HNc7aFXXo=;
        b=AuU1ZM0b0J/sYQQgQCEcYMRSsVyhrBE/+pwK5QjC65P1TL+imiGyaHj81OV/5kYmlQ
         EDJ9avlF2lS0+NVQAwickYbOq4xApZCe6YDHAN4F8FgyBUWAgvvY73nXbYHLKAivDKpp
         tXNeocWW5MwlXo8kjmV2E7v/epv7QclfqphLy0BPPB/A0rIskskiDAJOpvef9zBlmYm3
         DsSYbvsCkoJRjvHclOFBZK6QQyXCg3xPwIcw3/e/sxveYiSDvA1hJOXZ7TlBd91rVdMq
         6ZiLjEfmEBVRZWk7zra2lp8bkFtTV8+gqY6/La+MxyN8eT39hLBHN65tcJVgh3LKNV+s
         HMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417392; x=1734022192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW3nVyGBjPmC7MmiF6/pZIPadVScmOhCq1HNc7aFXXo=;
        b=P72ewkIcNmAJIQJBJqiwzh/Gl1kC3cMAU5coDUg/zYSEWPJxHblgeLWqFRYmq2yiwu
         XMMolMH+zCYVc435zkIBEdsCIPQLLL9xHoiZTYXzt/RzMWEur/r63v9XJQ9ZaPNIQT+a
         OVJDPfdDT3nkTaQ7cGjQIej6mskJCah85UxbqqPzbYhmGJwtXkY+5mtAX4o20Mno21I2
         X5HPMreVObakE+X5Gg5Ne3jUMrd4fFE/JRh4B93KVqQyL+WoJ17EbbaIdfITIRayjcTt
         Lzn/wY2xw6Zy3odiw3LroSFF5/CZDYCRegqX4DximFd07/24TjhjTn5uD+mJOmu2n0+m
         wZcA==
X-Forwarded-Encrypted: i=1; AJvYcCWT+uC7HwrYXDuLqdkO9BBZp4l2efY0HKioYXM3wjp2bxy//2Ge8C/Th2RAXQppPLCDTgYwKKNWRenQMZgquMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuwbZ5LsJfymRd+07d+6z8oTKPoSoS8osi9ZuJGd+CYz7n3H1
	keTJ9suh+NDKCBnrfdNU0SB0azuEwVSnQ2eTmuD6M6YLvcKxeEE77nZ01CngnQ==
X-Gm-Gg: ASbGncuowxDm43IrBcATbzQFQvkXUvQfrZYeMJnJbnQsq5SgzVnpoHu7+glhAYxLXF4
	C5tLuAkzv5rNQrLXVPb0ngHtOvRagOk5bfvCK+pZYsgRZMrHTizMMQJi7zZ3r0sI8xAJEyZ79MB
	3v2zfwDMTyvbL05Fnm4SCOlVpzTS8goWh+OfSIbfX2h5yq+JovN/HXAbf2RwcoZV9NN94apoNJw
	xkNst/JlE05ImPNymTcdk5JrQl0svHvYYr6QOCKZwG8E/n0KcmloA==
X-Google-Smtp-Source: AGHT+IHnNtX3tMSLvvzcJDM8mmCSzkinGh0IAdf8rfXDHhivEiWh9ktaKhpLNJyQ3rzbGBSrdnX5wg==
X-Received: by 2002:a17:902:d2cc:b0:215:9d48:46f9 with SMTP id d9443c01a7336-215f3ce4f10mr59397415ad.21.1733417391540;
        Thu, 05 Dec 2024 08:49:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:205:a344:96ad:4260:dcb0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26ff2sm14609405ad.227.2024.12.05.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:49:50 -0800 (PST)
Date: Thu, 5 Dec 2024 08:49:41 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	cferris@google.com, android-llvm-dev@google.com
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <Z1HZpe3WE5As8UAz@google.com>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
 <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
 <202411151215.B56D49E36@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202411151215.B56D49E36@keescook>

On Fri, Nov 15, 2024 at 12:38:55PM -0800, Kees Cook wrote:
> On Tue, Nov 12, 2024 at 07:08:32PM -0600, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 11/11/24 16:22, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 09/11/24 12:02, Jakub Kicinski wrote:
> > > > On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
> > > > > Use the `__struct_group()` helper to create a new tagged
> > > > > `struct ethtool_link_settings_hdr`. This structure groups together
> > > > > all the members of the flexible `struct ethtool_link_settings`
> > > > > except the flexible array. As a result, the array is effectively
> > > > > separated from the rest of the members without modifying the memory
> > > > > layout of the flexible structure.
> > > > > 
> > > > > This new tagged struct will be used to fix problematic declarations
> > > > > of middle-flex-arrays in composite structs[1].
> > > > 
> > > > Possibly a very noob question, but I'm updating a C++ library with
> > > > new headers and I think this makes it no longer compile.
> > > > 
> > > > $ cat > /tmp/t.cpp<<EOF
> > > > extern "C" {
> > > > #include "include/uapi/linux/ethtool.h"
> > > > }
> > > > int func() { return 0; }
> > > > EOF
> > > > 
> > > > $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> > > > In file included from /usr/include/linux/posix_types.h:5,
> > > >                   from /usr/include/linux/types.h:9,
> > > >                   from ../linux/include/uapi/linux/ethtool.h:18,
> > > >                   from /tmp/t.cpp:2:
> > > > ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct
> > > > ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’
> > > > invalid; an anonymous union may only have public non-static data
> > > > members [-fpermissive]
> > > >   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
> > > >        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > 
> > 
> > This seems to work with Clang:
> > 
> > $ clang++-18 -fms-extensions /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> > 
> > However, `-fms-extensions` doesn't seem to work for this case with GCC:
> > 
> > https://godbolt.org/z/1shsPhz3s
> 
> Hm, we can't break UAPI even for C++, so even if we had compiler options
> that would make it work, it's really unfriendly to userspace to make all
> the projects there suddenly start needing to use it.
> 
> I think this means we just can't use tagged struct groups in UAPI. :(
> 
> I have what I think is a much simpler solution. Sending it now...

What was the follow up?

cferris@ is reporting something similar for linux/uapi/linux/pkt_cls.h in the
structure tc_u32_sel definition, found while updating the kernel headers in
Android. Maybe that file/definition needs the same follow up?

~Nick
