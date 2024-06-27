Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84F14830A;
	Thu, 27 Jun 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488091; cv=none; b=Bh1GNxBJ3w4rHcysXWfg9nZ/qRojm4Onn/hWoiYTi+Cv0g77xoaA9Cc64+OOGqVyPTLM7adhqdTrCXPDfMw7srQLGd9uWQ38tNV40cldvHuSKOCz7ASmPyHldj7vZ7dj3VfIJHyhQLHbyhdcq1wAB7PPoTd4JoSvsUSvSPVO6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488091; c=relaxed/simple;
	bh=CmAR5kMvFVRlfa5jgzt3p56Rd7SIxqA+LoMBBp1wo6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7M5KWZDyQCkeSjKdsdQjsH5PzXnlVDmZp14sA6kFeSc/pmyuj7M1gPqY46hmDBJlCPxmUVKsDiddRJ4SWTwO7nGDjHYjaTmRyLf+QWwhpsP8PTNHFDag4+R4rip6g32OfHta0xOOF0PMdel2VHZXcUM0wicJWYpf43aXoh2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NUzAUhvT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NUzAUhvT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7Pgf0B+XRFZIZWldbVmqB/GuVsACieZa/pwPEpHKnY0=; b=NUzAUhvT81f+lHLE
	QcuAV7cSSwtAEresR8akmeOztcH4DqHDTjT4+hUxhUDCN3CuW/RrA1WcfitzVPpms1pLT1pXGs5zz
	KgNSgf7/37X0/jg8uhwcSbH50FCsbBkE/35h+MvnJ2l1cTD8LITKdZfvCkAWOW5/gqDHG3ndhEooa
	Y102Zcqd77lWvWuYAeM5tFZklTN9DOCz5sixYiHYfXpmQuaYFaYMt1WEoOYH3h/NkEPDXfcB2yeIs
	I55dWkHuEyV4JHolmuEaxjdqc1GC4nP7oCsoKbsXj3ooOSN0Q6rOLk5F+XvCn5Q0W9j5n4BwDc+L2
	8gpAME9bIvzT30vv8A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sMnOf-008ere-1J;
	Thu, 27 Jun 2024 11:34:37 +0000
Date: Thu, 27 Jun 2024 11:34:37 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] parport: Cleanup some pre-devmodel code
Message-ID: <Zn1OTXZLer610kvs@gallifrey>
References: <20240502154823.67235-1-linux@treblig.org>
 <ZkXj9Ip3DoUAe1wt@gallifrey>
 <Zl3_5MzTNqIiXM_C@gallifrey>
 <Znw2oRnqaZ39aXzQ@gallifrey>
 <CADVatmPWjOEkt+_KQXcyPFQy7651_ZNnxZO2tX2Hd=1u20eEEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CADVatmPWjOEkt+_KQXcyPFQy7651_ZNnxZO2tX2Hd=1u20eEEg@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:34:14 up 49 days, 22:48,  1 user,  load average: 0.09, 0.04, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sudip Mukherjee (sudipm.mukherjee@gmail.com) wrote:
> On Wed, 26 Jun 2024 at 16:41, Dr. David Alan Gilbert <linux@treblig.org> wrote:
> >
> > * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > > * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > >
> > > > > There are some remenants of the pre-devmodel code
> > > > > still in the parport drivers; try and clean some of them out.
> > > >
> > > > Ping!
> > >
> > > Ping^2.
> >
> > Ping^3
> >
> > (Added Sudip's other email address, and also cc'd linux-hardening)
> >
> >
> 
> Apologies for the delay. Somehow it missed my filters.
> I will check it by this weekend.

Thanks, that would be great.

Dave

> 
> -- 
> Regards
> Sudip
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
