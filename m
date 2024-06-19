Received: from mail.nicolasbianconi.com (mail.nicolasbianconi.com [198.98.51.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14B13D525
	for <linux-hardening@vger.kernel.org>; Wed, 19 Jun 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.98.51.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797286; cv=none; b=KIpEAf2OV8B97QD7PqQG9iP6nwoCOneVsE2w/9wouAEt4uAaBkO6PuzFth28uQ2ouE1yEHRVdlKmvaRGLwhYC1SHOqPRLnPKVvCSbQauWL29AVg81HGzTN0m+nuIrB+8FOqfBPGcLShhXCg73Wop/SM+j77GCqv4DsUoQMDaQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797286; c=relaxed/simple;
	bh=E944myTFMlpKa6Lg8zPV7huir00shZAraKE3zdbDM9k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EVLuQuTqOKoPsBiJAal7nPK8G+EuhHtxZADB3lV7Uf6qMF1OPaDOjnB2w2uR6gDKLnHJ46RDQcJ4g1xokxJ2+3F744s+rTKxgdluSmeExkJqTKotthMasQlBdVvTDVUy/TaX7lChqshONS9n2U3I/boVtKB1cfH1grY+31kL5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nicolasbianconi.com; spf=pass smtp.mailfrom=nicolasbianconi.com; dkim=fail (2048-bit key) header.d=nicolasbianconi.com header.i=@nicolasbianconi.com header.b=mq3pTVMZ reason="signature verification failed"; arc=none smtp.client-ip=198.98.51.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nicolasbianconi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nicolasbianconi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nicolasbianconi.com header.i=@nicolasbianconi.com header.b="mq3pTVMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicolasbianconi.com;
	s=mail; t=1718797271;
	bh=E944myTFMlpKa6Lg8zPV7huir00shZAraKE3zdbDM9k=;
	h=Date:To:From:Subject:From;
	b=mq3pTVMZfENJY98lZw/mpOuf2u4YwNd4jTQSn1I96AFGACvnkfgUVM/DmnrDtfXPo
	 EVPKLzMyllKYAFN02PjJYgwUYvzNuWbsfBHGx+iiq/6/LHDdIyU73Ff6/pyzGyafTf
	 S1JVr5ODLglbTZsJtYY3bK/u3suE/kLjq/giAmygkzbiiyr5JIkoYYwGSQ7NaGZI75
	 M4KoD6f+N8e/BFxepay7KlBXwnAx1mtrAVEy5T/GEl4wB+PmAtEu1hPa8kt+VkNNkW
	 UzEw60eoDrjVPspw4cGh6UnOu4MBPvTkF7UtlDxYPOtUELAh8BMnTyasFyQqK90e0e
	 OWHTCHUwPD8Wg==
Message-ID: <3424f6a6-34f2-45de-a3ac-5783833512eb@nicolasbianconi.com>
Date: Wed, 19 Jun 2024 08:41:11 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-hardening@vger.kernel.org
From: Nicolas Bianconi <nicolas@nicolasbianconi.com>
Subject: Linux Sysadmin Offering Assistance in Kernel Security - Ready to
 Collaborate!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone, My name is Nicolas Bianconi, and I'm excited to join 
this community. You can learn more about me on my website: 
https://nicolasbianconi.com. To summarize my experience, I’ve been using 
Linux on both servers and desktops for over 7 years and have worked as a 
Linux systems administrator for more than 4 years. I have experience 
using and compiling custom kernels, and my passion for Linux continues 
to grow. Recently, I've become particularly interested in kernel 
programming, with a focus on hardening and discovering CVEs within the 
kernel. Although I have only basic knowledge of C, I am very eager to 
dive into this challenging field. I am seeking guidance on how to get 
started with kernel hardening and security. I would also love to know if 
there are any ways I can contribute to your projects or assist the 
community. I believe that my background and enthusiasm can be valuable, 
and I'm keen to help in any way I can. Thank you for your time, and I 
look forward to your responses!

Best regards, Nicolas Bianconi

