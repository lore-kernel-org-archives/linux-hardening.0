Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826462;
	b=xPLPTEmD2T72gJDKGuV3x+T5/wcMc1AFPRYhB6p5cr5Z0OPEl/+eIqP0y0VvK/5qH0WG
	 Koph7n8OoYHiR2khLXlnZlGJ45IAHdr6BYIW8PbxZ36bAHTIw52bgynMSQDsViH9ndk62
	 fHhF1OZClYUVLhagGW17Kgoueuw3ISnd8S0dprAV1nwQmQL5u9ECN3P/4E0Tu04b/yMAx
	 AlXBIEvqKVF9Qfk/3yrgJQtO0UzdWo3t5FmdZB8lHmLp5JhKMNCAP7oCVU2Z6hQ+WE9ZO
	 ORbx4lsxGNoElrobllSSA/sJmDN6tjzaGB4NXWHDIWg+1oWQM5m77d/olC97zYLEE/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826462;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=BIWwTRYTaBPAHlWposIOtokLSiwg9bL7hag8t7zvCh4=;
	b=If7Y6Isi0zkanQCgpGUvSr3/4msaYQk3ZqI29g/eQ0xpO7vzlfJjv7Gb75ZUn7l0+Hhf
	 zyqegsKTAJ60XOjJnEAWeNrTDsrxN/iuyqZKbJxWcsQS/DaA9GG860F5pf+MG7aXDdQFw
	 4nxye3Dheg/PgeSlrrTKEOmPeAuEz9o7gJRJof5nG7MTtv7m7nHtgPHanP1cBtBtaCFLr
	 hw6IbluM5ZfTXu6YB9WLGczSThNmcTVAyRwPu5PiBsxwLgB5zUfRjNZU1HV1hpFtIgaPo
	 B0Hasj+2cvfEFh9K26HrYFg/MMIn4PFJkVXMyY9kX1XxTGbhWjHoq1l/GLqUqJxG7Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyUYoNNM;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E075606D816;
	Wed,  4 Nov 2026 21:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E075606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyUYoNNM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793826457; x=1825362457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1F8JaJ8aiqw0BarEPO1tt+vgJs6Xe8tWpLSoVWHy5U=;
  b=AyUYoNNMGT6JiRQC4+lJw8bYolDc9Avgqu6ReF7vbsD/qT8ioBOZhKL+
   GSuA3DVfz8qUwcxqNEyLaC9mx40wKsxt4aYpNb47I7mfosur756dIk8gR
   FnrbwPbtltg67Dr14cMYOEfiWiKhOuBb6LZnhn9QMDkynB6kZHYTJrMqC
   r4RyrNtaroW2VxVkwWonxdT+oPqg/2ZznaAD6b+VmHH6GPyN+yNWWALmS
   umh7N5whoVqVg1P1dSsOAMuj1fC46N5sjqkl8AaxwCR3MYFD+YLY7xCVy
   CKhbf+mzOg3fQoBVgQnw8OK4JxSxWyWzxQfZYVynkrgdbE98iG7clB5t4
   g==;
X-CSE-ConnectionGUID: wGpApA3WTy25tuij3K3vFQ==
X-CSE-MsgGUID: sMRVhrBFSGOvYK8nNqKuaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2690643"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2690643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:07:36 -0800
X-CSE-ConnectionGUID: UIRrZ91lR6iQIZbysWdYCQ==
X-CSE-MsgGUID: 5AcLI8a6Qoie1kFAiVTJEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6982505"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:07:30 -0800
Date: Wed, 4 Nov 2026 23:07:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/9] lib: string_helpers: implement a CLASS() for string
 arrays
Message-ID: <auuekJTgjp8oSfgX@ashevche-desk.local>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-2-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-2-6e28fe1c72c4@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:03:44PM +0100, Bartosz Golaszewski wrote:
> Provide a CLASS() for managed arrays of strings. It can be used for
> automated release of temporary string arrays when they go out of scope.

...

> +struct kstrarray {
> +	char **array;
> +	size_t size;
> +};

Hmm... Why struct strarray can't be used?

-- 
With Best Regards,
Andy Shevchenko


