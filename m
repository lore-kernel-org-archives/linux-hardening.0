Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C031DB34C;
	Mon, 16 Mar 2026 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703861; cv=none; b=Q//WjLr486K4RfOLVB9cOCIqSp5XIvqXL0prEmw3rlcCmEkQiK3RuhprHV0lUnla+Oy7+9g83BWpaenjFLIxCvYkc9zbVn1vhz8RrDH0EI2SkDgJW9jA5bDQl9V0C+x1X5xcxKMMM8JWw21dkhP4XNiW9qmbd2kSY50Av6NWzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703861; c=relaxed/simple;
	bh=9T4KdikbZg9icpIwVhA/pQBwmWRxJUFKxi0dFysI9+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fkHgmQ34G+Eo6FV616ZQTgCWdUKKUUKek4oUTB1o9+pgffbgMuBDK2IPC4Ipu7AZbAMhCRJyEDJjsXhheDiXj3zmSDiLpSP7VLWlkNvM562h4n9Zy0/JH39gHdMndRF9GT5vSARaGrRaZAF2MXyOaXNqt3+/24EWxM9XM9eGFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oQP3ahBe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oQP3ahBe"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 969A640423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773703859; bh=puxEkRYw4pDuk2hQygWxoBdhct66RGKWS3P7st0vqTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oQP3ahBe8HAr9DYhIloRVlA6427hatTJwk2tiRkVLxQDvXDdba7G6p5hh7D1+A58N
	 sXL/0G6cLknjD6WfrPi8IbfpS61RqhpDrJLobx3Otbyqq50BhRun2jDVbHXgOtKOCc
	 t+7+TdNrUlaRl6rJSOBd04WaUEAHnJq7hiC9GqmFMJtJQzmUOLgntst2bmrkE4z+4R
	 VfEonN6g1Exs1mGYIz2KRXYMhfL0POv8ElH9gOP+WErg044UfDtjSQyjapSYX2B+su
	 V7SicxHRdsXIfpsGX3ks06tifpQkgNqgpxpsWSx8JZdzgmpsrtodc0CM8yH3JOnXWB
	 rymJgYC8d0jaA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 969A640423;
	Mon, 16 Mar 2026 23:30:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v2 07/28] docs: kdoc: move C Tokenizer to c_lex module
In-Reply-To: <6f325ef5c6be846c21b0c4df0f48bd0deeb236b0.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
 <6f325ef5c6be846c21b0c4df0f48bd0deeb236b0.1773326442.git.mchehab+huawei@kernel.org>
Date: Mon, 16 Mar 2026 17:30:58 -0600
Message-ID: <87pl53fj2l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Place the C tokenizer on a different module.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/lib/python/kdoc/c_lex.py       | 239 +++++++++++++++++++++++++++
>  tools/lib/python/kdoc/kdoc_parser.py |   3 +-
>  tools/lib/python/kdoc/kdoc_re.py     | 233 --------------------------
>  3 files changed, 241 insertions(+), 234 deletions(-)
>  create mode 100644 tools/lib/python/kdoc/c_lex.py

One has to ask...why not just put it in its own file in the first place?

Thanks,

jon
