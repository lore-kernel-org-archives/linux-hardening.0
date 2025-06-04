Received: from s00.xyz (s00.xyz [144.202.8.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953BBBE67
	for <linux-hardening@vger.kernel.org>; Wed,  4 Jun 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.202.8.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749001884; cv=none; b=YCHLkyiLLu4rIkQm3utzWgujH81NBhZmgGiKop1Y/h1D/p/lhnYM4zHOESV3xKcVy9bzR9bBoGphya8KGFlXXMMua+ZESFe3GJnvbmrHYAav7bxcuYDM2eivlAMyD5OzeRlR5PlXWQazZCqvq9fqMpw5tm1QxWeR5kF+6kqsURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749001884; c=relaxed/simple;
	bh=UluO+exoNCnKHdpa7NXyQ6lSv0U2PbGAT9iyQEvLsuo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gEP0PRWnjrlLBungWkOdl/GBp7GfEubcmkMGIgvLS582ieoM0GRbxPhhMDAMdU9PpUYZ/sBgKsLJFsE3/jiDia//R0DjaphRgLuq2LfMhH0vp0weoeUseafHs8LbDZvFsI/vNzRw2oRD8s5xnfUDC28Cmpjy/oYl3hge5TQzXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=s00.xyz; spf=pass smtp.mailfrom=s00.xyz; arc=none smtp.client-ip=144.202.8.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=s00.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s00.xyz
Received: 
	by s00.xyz (OpenSMTPD) with ESMTPSA id a0d82044 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-hardening@vger.kernel.org>;
	Wed, 4 Jun 2025 01:51:17 +0000 (UTC)
Message-ID: <294faedb-f740-43cb-b07e-5b0f9e574499@s00.xyz>
Date: Tue, 3 Jun 2025 21:51:16 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-hardening@vger.kernel.org
From: Stefan Weigl-Bosker <stefan@s00.xyz>
Subject: [Self- Introduction] - Stefan Weigl-Bosker
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
My name is Stefan Weigl-Bosker, and I am currently a second year 
university student. I will try my best to keep this short:

 > What topics are you interested in?
I've developed a bit of a focus on compilers and linkers recently, and I 
am very interested in static analysis and symbolic execution. Generally, 
I'm excited to learn anything new about computers, linux, and security.

 > What do you want to learn about?
Everything :) I see KSPP as a great opportunity to get my hands dirty 
with kernel internals, computer security, and open source software 
development. I am far from an expert at all of the above, planning to 
start small, and looking forward to gaining more experience.

 > What experience do you have with security, the kernel, programming, 
or anything else you think is important.
- I compete in CTFs regularly, and love doing pwnables in my free time.
- Conducted research related to network security
- Other fun things: zig's m68k-linux target, a risc-v bootloader with 
physical KASLR support, ...
- I've never contributed to the kernel before, though I do have 
experience compiling it and reading its source code.

It is great to meet everyone,
Stefan
