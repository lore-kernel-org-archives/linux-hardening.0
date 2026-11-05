Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902374;
	b=pvYQqYgHI8bPqPuRwWKW/CtpvBDbJsT2galqV7lkmbnk0NTqQMcTJ7YAKz+fpTMT5Ijj
	 OnTuhVvWQeQHaRbhHdRW1+4KPMS3ioQs7hWc5JyJbkrLnmg0JaG5vuE/WfKtHf6F7rgsN
	 ASpUkDvvcFnh95VLAaB5fIl+HT1Z35YEiNY9Ke/VNtCDJHF6Pbs0Qr52maISRdjZki1QO
	 ewxOC68gJ5qBzJPH4oThd/ttM3/LGqtasE/0kRGuyW2CDMFSdzs0JJzcK9SK8eqljXOtm
	 gKPfwamMMnRWUlowbh4BBgAwkYZHl4gAPB/3FyoW2j0eGtHqhH2WuwFJp1N0mDOHBdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902374;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HF0Vu6VSMOjUFmnKIzWkq+Vw4SFQ9ACYgeHBYhFMgzw=;
	b=pr6NcfL6s3Y3BK2W3A530GpOIzoURkSHYruAqRHZX2lQpE9Y+k3JENpjDUgxhq9tq8FB
	 LgngbEIg2AfeM40MELHbdDkITQR++RU4DZ0mNr391yFtLOR7d1dsZPuuGRVTaXM+NrKvp
	 ohI1+t2SSehN+Zqwm3g2xHckEvtfYd6ZtRr9OOVZrArCVcJwj9MgtaZj1A8MGklf3S9Ej
	 wJnHPGN5wwnSsvBAr0tmAKiMVwaPX6Ns5iKLDGQyLA7e2HfKwXrGaryd/rH4vUSZweBJk
	 M8U57JJRJZY1q6tVzDS95HOgAcfsUCxm5QvW8PD4IyhC1zgQQpKlUegQWPTESbZZhyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLOeqqep;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB55606A332;
	Thu,  5 Nov 2026 18:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB55606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLOeqqep
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793902373; x=1825438373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnIGBm5gDZbm79UwkA8MEm2OUw3yr/fKfWYvNqxqn1I=;
  b=OLOeqqepGvILSMV8sv86PZdPp2w42DAZ2A02b+DFCeElKFM9cSQDrog5
   NugsMFIJooNghwqPaR7kNftP4Yp5nbTD2IvoVL+OgSmzTsUrSQ4dKtuih
   sGZHSC5VVvqVWIl2DOS/8gznBSM9e8259hWVbin552NHQMI8Pn9Y6O1lm
   /qJC4Vq2MieX0cUXQNJeP9I4pXEj6cWvXZiXDw4noMfoiLG5R+Hho5TE/
   GkNvke2R6Or2B/cPzU3uG8vsgDrofvyqeCq0FAv2a+9mURb8MAlLUN3gN
   jo+GIZ9yF3i5sxv+Umytx202Qrh80RPx1rfFkcyjAouvm8fpxbb9QrOdJ
   w==;
X-CSE-ConnectionGUID: NsFniMpTS/a8si4vwoCOTw==
X-CSE-MsgGUID: 2/C+29GnQ8qTvP+1kDg3CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2696944"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2696944"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:12:45 -0800
X-CSE-ConnectionGUID: Q4LZzfRwSh21y2t81bRfmQ==
X-CSE-MsgGUID: AlzSNgyqRdq3s8uEY9Ce0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8842063"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:12:39 -0800
Date: Thu, 5 Nov 2026 20:12:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Len Brown <lenb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auzHFRzd86iV4-RA@ashevche-desk.local>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzGMV1YbO9DodBq@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 08:08:57PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 06:46:18PM +0100, Alejandro Colomar wrote:
> > > Date: 2026-11-05 11:50:19-0500
> > > From: Steven Rostedt <rostedt@goodmis.org>

[...]

> > > Oops, typo, I meant trace_event_filter.c
> > 
> > Still not found.
> > 
> > 	alx@devuan:~/src/linux/linux/master$ find | grep trace_event_filter.c
> > 	alx@devuan:~/src/linux/linux/master$ find | grep trace.event.filter
> > 	alx@devuan:~/src/linux/linux/master$ 

Besides that the above is yet another "Useless use of grep".

> Oh, you are an oldschool guy :-)
> 
> I can't believe people with Git index available are using `find`
> and not `git ls-files`. `find` is too slow...

$ time find . -name trace_events_filter.c
./kernel/trace/trace_events_filter.c

real    0m0.081s
user    0m0.028s
sys     0m0.053s

$ time git ls-files \*trace_events_filter.c
kernel/trace/trace_events_filter.c

real    0m0.014s
user    0m0.010s
sys     0m0.005s

$ time git ls-files \*trace_events_filter.c
kernel/trace/trace_events_filter.c

real    0m0.014s
user    0m0.004s
sys     0m0.010s

$ time find . -name trace_events_filter.c
./kernel/trace/trace_events_filter.c

real    0m0.083s
user    0m0.021s
sys     0m0.063s

(with IPC to `grep` it will be even slower)

-- 
With Best Regards,
Andy Shevchenko


