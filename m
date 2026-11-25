Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644013;
	b=edhykA/pkt/iAnG7usvEZ7ZaMcOTE2st/aR2QopWwx+o0434J7jVg1LvsMfQsaogkHKM
	 3wHVKkId2AoVVQXNjCHWEU4FrCgbGYQa7zTCgcybPoOYIOr7goMg8qYO8/yqOhLLkQlsu
	 CqY9rvCD43EnrQCtI10lvJibl97nlRSUd4jRbQIqO/55kfv61RhrdAm6NbW6KVg1/uB2h
	 3Bb4U502uo6h+kfQ5G8GdW/zJxEa4e3BvgJ2Po0ZLw5aUpWLBqbObglvkjZrWeS5vYS6X
	 iiH8bDXse4uEB6clg0ZI9nx6N0fMO8o43S7Te3hzrSNEA9gBlCrBVjO9eXgfARan3Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644013;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=CZgE/cs8BmHBYJeHeFg0PA4Bg6yL0LsgmHmGpETSEYc=;
	b=IwfOHAh3hv7Lw34JPwPlcGwIU4lIJf8PJ/GnWLnj6Fx8PnxnYJOcC3bozu3vjwmS3wIZ
	 5fDYxT3a8FueGSFNO/qf09oIdbL9K8VBQtNUfmtPmQzLKQMyJyiOrJ6Y+/SjcSw5GsBKX
	 fjt3V0QwOOfsawklr2esflc/xIwx6PBpidmL9D2E3QoOBv74l+Ajfyla9wKHOhczL8lih
	 fYkQJ4ohA3BJOz4RHegxH+v8k9dYE1FJIHP1piaH+hY7ykbeuPmlCqh2ndd55H7hRKmnp
	 gi+OqxonPvH8gclHFN7dRthig/d2q/5SM+e5v5VsdeiQXTFdNZ60zt0D+m9GIk9VZJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="MB/J78b9";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C8606A32D;
	Wed, 25 Nov 2026 22:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409C8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MB/J78b9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795644013; x=1827180013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXp2C8wwC/7e9kBMRv/8D3ChViWKBq02WLPtjgK6+yg=;
  b=MB/J78b9a4CrGdZkVpe6g3Spy2ift4FhVmdGc6WcfnrIsSmK/NRMJKPQ
   +pGvF1aPZ+qaDyDeUazhEn2F2e+qFMcW7u4OFgXwXBbULeCR+eQHwvjbx
   pmapp4T6LXZfLGJ83MHVlBr/NWmk+EAM33zHFKrnBFLw4zBWq607o3HOY
   MFYpA/E00N98CBH9X4ikK8q5wKhZqaLUP35fAMb+iuriXpmlY0oU6Z1hr
   jfcGwWHifyjMaYM71O/ZWyg+p0wrnig3vwPYzu1CslcoIKGGyex+WdOHr
   V/B+44B9zQtWNmeHVhl2+RivRCCvZFyFhrhglNxXCPKF0skufo2qH9yEa
   A==;
X-CSE-ConnectionGUID: eQyHSMgLTgmQMn2ERUzEBg==
X-CSE-MsgGUID: aEl3kZlYQ7OynXlkA14g+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4532481"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4532481"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:00:13 -0800
X-CSE-ConnectionGUID: WoAZdoOXRN2ut255l05zhQ==
X-CSE-MsgGUID: aZlfixC7SiiBlZeaOOQE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12296235"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:00:05 -0800
Date: Thu, 26 Nov 2026 00:00:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	alx+linux-hardening@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <awdaYz9NNVv5fHv9@ashevche-desk.local>
References: <cover.1795639368.git.alx@kernel.org>
 <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
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
In-Reply-To: <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 10:03:55PM +0100, Alejandro Colomar wrote:
> str_has_prefix() returns the prefix length on match and 0 on mismatch,
> so the mistmatch case can't be told from "empty prefix matched an empty
> string".
> 
> For instance: the OF root node's name as returned by
> fwnode_get_name() is "" and will return 0 for any name matched against
> it and since len is 0 too, fwnode_name_eq() will return true.
> 
> Let's use strprefix() instead, which also makes this function simpler.

...

> Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
> Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
> Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>

What is this? Is it documented tag nowadays?

-- 
With Best Regards,
Andy Shevchenko


