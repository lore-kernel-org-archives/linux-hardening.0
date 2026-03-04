Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC91261B6D;
	Wed,  4 Mar 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618876; cv=none; b=bOnYz64IBku3WTPwJGwVuatxo5R01tgmcNnpwCpICqfhQ2QQAInPCYOLmGONvJTwNGEovdzqkc1XTiOcss3h1duVJ7P8Bei6+sZxOZvNfrrriX+G+NlKXMuTPSF3lDR0L5qR50lveltpBQwZLlsiW2WjBZ3t3GySKRkRgqU4u3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618876; c=relaxed/simple;
	bh=4nLniX2BsUbSbyK0ug4iVQYKHRMIZaO2R8VMdLqlTaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9RtP8KUwpnWvEY3i/LT6UGqVxpHyoPMzrrfewdtZPc+STgZY6NR8LO6FpD+8ReC0A191Ssy9QWw2hrHIU0W9GqYOM50ANo8AtqIaPrkBc+7/Kvef6AlrP25Bl2ZORqn6I/CyPgtp6Y11CwH8+R9FAns1B3JPK+s+tv3YHAI8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsStdSp0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsStdSp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772618874; x=1804154874;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4nLniX2BsUbSbyK0ug4iVQYKHRMIZaO2R8VMdLqlTaY=;
  b=OsStdSp0jLKnF7uc7hBVoXufYFgzzw0ytDeRQFvLhcDqNN6Cadi9acbH
   DY9x8Wmi+Q0cG5G5xSiEUVuB2q0TJcE2oG/H1RbsxNzkgJeuv3OTBicMi
   t68G1+/tHTbI+1IrNC41tqm89SnWf/0+S5Dtp5CV7oV4Q1/95UExPGP00
   vkoK8q5GKr/PX036dbAskhD1vi1Icef0X8KqhYZVR++mK1wXdRwIHmPGz
   /E0Gr5H9HrJFx4gYnAzTUdHobVauXtPTDHTOQFimqwCW/v4y5Vca60cia
   B7BOa0iBkHVBh8ilyy5CfgFh3t9ymkOVDcjpHFT5oKuyNi4Az6NCqE3lV
   w==;
X-CSE-ConnectionGUID: jhCCd+1aTVSN7CYYz6dEFQ==
X-CSE-MsgGUID: ch/Sq4PEQfW8AGkcge17zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73802856"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73802856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:07:53 -0800
X-CSE-ConnectionGUID: bz9U9LFUSsSRQ/6Br6NcBA==
X-CSE-MsgGUID: u08Ynn+0S6q5PdDfdJkP/A==
X-ExtLoop1: 1
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.84])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:07:48 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <878qcj8pvw.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <878qcj8pvw.fsf@trenco.lwn.net>
Date: Wed, 04 Mar 2026 12:07:45 +0200
Message-ID: <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 23 Feb 2026, Jonathan Corbet <corbet@lwn.net> wrote:
> Jani Nikula <jani.nikula@linux.intel.com> writes:
>
>> There's always the question, if you're putting a lot of effort into
>> making kernel-doc closer to an actual C parser, why not put all that
>> effort into using and adapting to, you know, an actual C parser?
>
> Not speaking to the current effort but ... in the past, when I have
> contemplated this (using, say, tree-sitter), the real problem is that
> those parsers simply strip out the comments.  Kerneldoc without comments
> ... doesn't work very well.  If there were a parser without those
> problems, and which could be made to do the right thing with all of our
> weird macro usage, it would certainly be worth considering.

I think e.g. libclang and its Python bindings can be made to work. The
main problems with that are passing proper compiler options (because
it'll need to include stuff to know about types etc. because it is a
proper parser), preprocessing everything is going to take time, you need
to invest a bunch into it to know how slow exactly compared to the
current thing and whether it's prohitive, and it introduces an extra
dependency.

So yeah, there are definitely tradeoffs there. But it's not like this
constant patching of kernel-doc is exactly burden free either. I don't
know, is it just me, but I'd like to think as a profession we'd be past
writing ad hoc C parsers by now.


BR,
Jani.


-- 
Jani Nikula, Intel
