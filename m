Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C7515882
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965829; cv=none; b=Lb2shEDuq6TPElqDRKjfvDW3oBCiG+K4RPKS8zhQGCOcOYZSBWnMH26eXUQ2xLwOeWNPIfuJAmg9KHiKTMbSvNaK0bjKziIEJsL2l2ZK5DDrBy/gScbYg6qTzfxVxqkFSNuGR95umOrasCs8BdMgLAUHi+UxS5Bid9CF3KP8EL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965829; c=relaxed/simple;
	bh=a9DGLc0NeseciOnf2q1+7VtYJ5eoK8nd7Li3zgPWEig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U4pgNDKF2YMGtBO1duzMbpcriODa8CI+Q6PiH9lcbSxMSO29jIfVi8I7aNZhuCDi/vZ0L2IpWlGu02zv9JAUozoVlNRnbNjnmD8s7vSCMzSKr9G1ZA5gOBClO4asfXVfTVDi3g8djJgl46qGTM53Nf8vtJenxWktIE/isYYz3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PP3bvG8A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PP3bvG8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790965821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHtc6IteGKWmX+tDrjk0Un6qMA2HmnuYgSyxy+UifAQ=;
	b=PP3bvG8AJ/yLV0Grw5HWjynqb8S14s4Mc0yMT8W0HCnP1upuJyRQG9nzXF/tsWlodBV2Bv
	LWtWTI6eZ4CWK8Eb3f3km+ADKxnEtsUPhVWR+G+VJEj54xd+Oat/Wl9ZltInOv/Kl30CE8
	eZeEbm3+5mvrpBNvDvaPEBXFCCE+Rpo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-4FUBd4BxP0uq0Ox_4-Cnpw-1; Fri, 02 Oct 2026 14:30:18 -0400
X-MC-Unique: 4FUBd4BxP0uq0Ox_4-Cnpw-1
X-Mimecast-MFC-AGG-ID: 4FUBd4BxP0uq0Ox_4-Cnpw_1790965818
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so485950585a.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 11:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965818; x=1791570618;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHtc6IteGKWmX+tDrjk0Un6qMA2HmnuYgSyxy+UifAQ=;
        b=hd0vNb+TCRGkyuPz6utpg7cL5AwGt6Um0Q0pn1o3CMIH9WSQL4T0I+bdUrXeHN4KUW
         WCrBMVvSbXDUJrSSkH5qjuquVigefkCHgGJdeQ0uw/KmKwO3cpqwhX7y24dkacvhcdb3
         9cpON0GsDRZiMOiw7NDpW/0Gn1s5ETU3rpvRvzQVqn7Y+rFjjMOjagRILIM9w0wnIMrB
         //UT6aAKICYlMLcpq+5DEPUqtcsckugIAisdVAyFGBlBdRKfZilhjITXtH3dNFGKtnvU
         RTToYmTo7UGY7q6VL35tvD5C4q5ezmpTb27JzsZl+S2YXJwNbcLwCO8R3D2KxslDKLAJ
         FLaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmlhvjTo6q3rf4ICZ6wfpl6IKZ1wt+uDbpvlkRn3S5eWNotWEGgEfCVz3Sjgl6L5ye0A/0cX0Ogxz6yzrvx30=@vger.kernel.org
X-Gm-Message-State: AFuF++mmYPzIcLGCBxcW6wHS9k7BORcewAvkkNMTMRv9DWZ7eaxtro60
	ZNiq2hDk2+Z7/4b+gfNZZUCxrW+yI0+VdM23IhRonlJQwkwmM6kK97VxmQxQ/5hA5Nb1NLZEP0V
	PPp06MLzdlGaMlt8LCcoGqRwNAyIUJPbA9Ld/lir51jttN6/epkX81sCUlBvGdYObiNsI9g==
X-Gm-Gg: AYBFou1WQUjREBdNH7SZcLFt/1ejhwu1HSiJxeXqcINwoGOPzG1LW4Czy09YM/O6lGY
	lSjfCrtDXFdBnf1IQUXrycUm+Bx2unaQ8jZ93IbNcs/vse7wzK1RkPHoKjSxgzW05o+XD2OznMu
	v2lC+e/lSicQXyKWdCLIIT87nOncx5c7D+3C/bQQXkwiyVKVOZjSDoyGsT4/WjCXD/UimIYKJ85
	IZ/ACB2zAVYsyFxCXTqmkFru9jj3VxHfkjqNsF4q38NCsQMCkhBhYjJKPf+Z696GKkvc/4uz2as
	cAMl/XoDiTmLoio/5LFaQVIofRJ3Ubre+nvbmMpTjAQHlORwg2pN5orzp8zDQ/Xz0MZb4kGgRg=
	=
X-Received: by 2002:a05:620a:31a3:b0:930:9091:f0ce with SMTP id af79cd13be357-93cf16b3b8bmr674429785a.22.1790965817924;
        Fri, 02 Oct 2026 11:30:17 -0700 (PDT)
X-Received: by 2002:a05:620a:31a3:b0:930:9091:f0ce with SMTP id af79cd13be357-93cf16b3b8bmr674421085a.22.1790965817184;
        Fri, 02 Oct 2026 11:30:17 -0700 (PDT)
Received: from redhat.com ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca0395dbsm285252285a.5.2026.10.02.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:30:15 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:30:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 00/23] Add basic clocks and resets for JHB100 SoC
Message-ID: <ar_4NBLHrq2W7_vc@redhat.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930-grafting-undertake-ff3e01060284@spud>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260930-grafting-undertake-ff3e01060284@spud>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TrfkOYb-czjE7ZwoTRxvHgBZ2zu5MVIc4LayZIp31Pg_1790965818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Conor,

On Wed, Sep 30, 2026 at 11:43:22PM +0100, Conor Dooley wrote:
> FYI clock folks,
> 
> On Wed, Sep 30, 2026 at 05:42:54AM -0700, Changhuang Liang wrote:
> > The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
> > subsystems:
> > 
> > The JHB100 SoC is divided into multiple subsystems, and basically
> > each subsystem includes a CRG(Clock and Reset Generator):
> >  - sys0crg/sys1crg/sys2crg/
> >  - per0crg/per1crg/per2crg/per3crg/
> >  - voutcrg
> >  - vcecrg
> >  - gpu0crg/gpu1crg
> >  - cpucrg
> >  - usbcrg
> >  - host0crg/host1crg
> >  - pcierpcrg
> >  - husb0crg/husb1crg
> >  - husbcmncrg
> >  - husbd0crg/husbd1crg
> >  - npucrg
> > 
> > In the current series, we will only add the following CRG:
> >  - sys0crg/sys1crg/sys2crg/
> >  - per0crg/per1crg/per2crg/per3crg/
> > 
> > The remaining CRG will be implemented in future series.
> > 
> > This series depends on the series:
> > https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@starfivetech.com/
> > and it has been tested on the StarFive JHB100 EVB-1.
> 
> If this revision of the series is acceptable, I'd (although I'm not a
> listed driver maintainer) like to send you a PR as I've done in the past
> for Starfive stuff so that I can get some of these binding patches that
> contain headers as part of a shared tag to be able to unblock a bunch of
> the soc tree stuff. With conferences next week I understand that, with it
> being -rc5, it's probably this doesn't make v7.4 but I figured it was
> worth getting my intentions out there!

I am going through this series now, and I have a few minor changes to
the clk drivers themselves.

Feel free to send a pull for the bindings and headers though.

Brian

