Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902138;
	b=jXvIHViKpP2paxuL4NsFqNpycjleu069gd9pfm0XG+ZUC22ZRMGCUDk93OeXGeO7a0yO
	 dhhWTd4ucRZggPqaKpWpEYnVcElvKPLndpNf6a+3H6PFP1H0AkYclj+8Igb1uEgv1hjEJ
	 5cGprBoYqemsFlm2B6n9E97TiKY6aHrZeO2HpfjI9ZHk8YfR3ZUCjv9k2+Q/qgmeuKDDD
	 jz53M2aRXAvFZzsncUtbeRykfQROpH3tl3Y/Om/xLjTnu0lKmDYbpoRFMAAqYRrL/iA2d
	 o939cJg7NbDpzk8MOcNzBRVVzNJNCwkLSdG0FECl5HwG/T7L6Ta5fG1uJfGtuYGJ4eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=OmJWt9jy32DuAAccMJWm3nkUUMzFdTd0nlAd4UIVKyo=;
	b=pSBmODvNcRZzMNosZ4rAeH6p+70R0HCAxWUWmC+NzjD22jOtLwg3C89imfJ+ZGBknS7n
	 n7B7R8ZhXEi3xIqWdZ+NKbYpn0uJd26px4gaoO3tpnXvdLpjJWcrFw/qq3t8fkmuCiivM
	 UDrCs4RS6/7RK1ZAzkAu3uwLDXq3F2l57Xww/c5HJDDTzpmxrAj7r10Msl4lfuOZo/wH1
	 zE/43HABoxjwNarmLSMThJTnuu6gQmwPdy4Q3yH3BOFhoFceWXU+r46GdSU2Gj1rw40PR
	 9fURl8p22h+GvNy6gvQ/lK0gE+8rQnsfkFSlrkwzT50JLjIYUl2hnExlBqJieU2X9bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZl+LRNT;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B16606A31B;
	Thu,  5 Nov 2026 18:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B16606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZl+LRNT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793902138; x=1825438138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8mPcNA+R5yTmhfrNdwr9xg6yzKlFMkZyh0EGXU8Rds=;
  b=EZl+LRNTA0+QWjwbvx+FbC9kfuk9ncqViCSIyy6iO8XTtIjrVxG9jcyZ
   M2brjjZa34aYpnloxqCPW8mkus0YClOU2cwIoFeXHzytbrCl2ujC8L4Si
   UefG5/obWNfoopkXxEjAoOoaosEtCi7OEybGqmQnqT5fuPC1CFC7FW2Xo
   0ShvcrZOG1u5jwr1lANvZAE+CfYbW6+PMWlhsr6oaoTKY7MdnY6NHPMBr
   xvE77GUDTEdHT1ccUH6XkOnjBy56lOXDn8Mzvjv3NwnjzOE7yMv5d2JyA
   2Yc2/9NLBawgXPaTk8vjoVgemySj7C5aTjLZiUoev9bniTB9H1hf1Wp0C
   A==;
X-CSE-ConnectionGUID: babqnDPkQTG6ltYtilUDDw==
X-CSE-MsgGUID: M7AjOkxAT5K8ivPuI/pADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2741623"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2741623"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:08:57 -0800
X-CSE-ConnectionGUID: EgwaX09kSoe48x2Zn1fepA==
X-CSE-MsgGUID: Gd1RVswyQ9S/hX4a8iTtLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7401641"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:08:51 -0800
Date: Thu, 5 Nov 2026 20:08:49 +0200
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
Message-ID: <auzGMV1YbO9DodBq@ashevche-desk.local>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
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
In-Reply-To: <auy0O467UqOzqYub@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 06:46:18PM +0100, Alejandro Colomar wrote:
> > Date: 2026-11-05 11:50:19-0500
> > From: Steven Rostedt <rostedt@goodmis.org>

[...]

> > Oops, typo, I meant trace_event_filter.c
> 
> Still not found.
> 
> 	alx@devuan:~/src/linux/linux/master$ find | grep trace_event_filter.c
> 	alx@devuan:~/src/linux/linux/master$ find | grep trace.event.filter
> 	alx@devuan:~/src/linux/linux/master$ 

Oh, you are an oldschool guy :-)

I can't believe people with Git index available are using `find`
and not `git ls-files`. `find` is too slow...

-- 
With Best Regards,
Andy Shevchenko


