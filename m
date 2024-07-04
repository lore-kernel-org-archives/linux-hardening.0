Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4C13D243
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jul 2024 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720136167; cv=none; b=fcDTx9yW6KxilSTZsdrz+6Vb2QQIU0U85PwyUwXkYqYjXfwHCbmKbQqMbAdcjTulWcFUjARY/G74S3S75wBsHWT/OK5ZWIwpBL+Fnm1gfHzqLqBAzRw3rxKn9tk6zYPJ9KDCw/LlZyCVr8cfBjqmyZ49RytLS/kjqdH+//KMP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720136167; c=relaxed/simple;
	bh=M/8Sopj9x9t3vKo3Z0rnnacCmswJdYM5Kbm3nP2eIps=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DLChO7/XOj6Iu5EXor0vGW+Zea7fwAR1uQb2NpDmhwh+yNpIlWe3WnNX0zKUbkVY+GLtAEeV/aqJ0XtpdqmjXTCt1iD0UjMPNenAbiAmgW3gbno19vZWIMs/dV7HV9LiEnFsdEI/W6eKK2HKEf1errB5CLrvGvYrk6+7X/LR44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq1wUtnn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq1wUtnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D75CC3277B
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jul 2024 23:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720136166;
	bh=M/8Sopj9x9t3vKo3Z0rnnacCmswJdYM5Kbm3nP2eIps=;
	h=Date:From:To:Subject:From;
	b=Zq1wUtnnblHFSBYHvJ7fPkzBEByQ5J9CV9ybPnfikrdYF064e4HypHzttNRoLfNj5
	 J6yfGp/jjK61R46mm5UtD3dNJP4QnMHy4qldOuyGkPq9Oy1MoQNLPhCgvrfQK6dpq/
	 43AJ4t4mm+CRpSPBeBEk1/kIJpnVYYhzUmi3zVK0yzmgYro13iW4/Ae7gh4uCwe4GC
	 IgKeFoW72pj6c5rtkuFeuslHxTDNCtG53hWOQ+4wnQmTwf3YVc0zxy+M2C/MAuEPDm
	 teMrsCjOtT880xBH3xagfLc7KGDqgKXX9mvIAOEeI990BhLO71a009J22G7ImsHrLu
	 /Ui+1k+1JJ5xQ==
Date: Thu, 4 Jul 2024 16:36:06 -0700
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org
Subject: moved Wiki to github!
Message-ID: <202407041633.43E84CCD8E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Just a heads-up; I've moved the KSPP wiki from it's long-time location
at: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project

to its new home here: https://kspp.github.io/

The primary benefit being that edits can now be done by anyone via
normal git workflows (via github, etc).

There may still some glitches left from the mediawiki -> markdown
conversion, but I tried to fix them all. If you find anything I missed,
please send a PR! :)

Thanks!

-Kees

-- 
Kees Cook
