Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C247ECD9;
	Wed, 21 Jan 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005370; cv=none; b=NdD12TXgAv2dw2fL3gESj9RuX7lrLeDyARJQ3/yNFnYCRBajlXppMY+pZ93tWHpadyb8pJh8VT/vPi5ODMlZLxBJPLUGy9kTnT/xoW5M283w6QZ3D5QNStAZi0FaRVU3ZfoVt9qF4lI2s3H6jPwXfdgy8/8VJja06ZJt0JnvQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005370; c=relaxed/simple;
	bh=dkzuheJ31BzgkjrYV8XBN7j2kGChh0nJwWSdIgvsGc0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KZ7QqT8shndj8JSxNFyVkR8MJ8Ll1qWn/HMwLIl1G+WNNkrlEYyhx/P4NHKcrRTSzmTLyXaDcF/ePYK3iiA/KHqax3E4boF+9tJPXYa9hUcnwO6UpmgoV0ndasq0HISG8H0dPiWYGZqfZd1mo9Yhb4caM/LIZo2ss2Cp2lhkEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=FW8EMShm; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=8vmWBwT+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="FW8EMShm";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="8vmWBwT+"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1769005288; bh=m1dJb0UHr6qP/RgS7yZiTdk
	diumzv85zdR8iC7uFHho=; b=FW8EMShmzIbDymUGF2JdrpOFddb+W0VJ1X6W3qL7KZqptjZjNJ
	8+acRTlrI/+HKsPkandZ/3wIoxZkVLQoH3lGB1QBBelNkISe+NiN02UKTt5VA6Rq7/90KB9MqW1
	Y96o2weWbx9autijSndd0QXu8uaI62/EX4C9jSYsjnKjbnRjwsmpk3Z2X/RXfl2kh6EB/qMvF+v
	uni5vf508hs3UGRKLxLCiMuYeXbvhNvq0E1DcByZaJfdPaXl+Az81WJiSVejSfVDuP8MPdCZYZx
	BXIbo/m1JyCLKpZKip9DDyMSsjDlvfEhOZeLkzM33BwVJCQ0poXpm0VdLKK7g1iBI1Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1769005288; bh=m1dJb0UHr6qP/RgS7yZiTdk
	diumzv85zdR8iC7uFHho=; b=8vmWBwT+ong3nosUITjncBdVXdqrGsVYAScfE7ns12mrD69zl7
	wvaXc7qJs9Ov7Z0m/3IaXzxkBPhz3Kul0nCA==;
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Jan 2026 15:21:28 +0100
From: barnabas.czeman@mainlining.org
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Gabriel Gonzales
 <semfault@disroot.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH v2 2/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct
 reserved memory ranges
In-Reply-To: <01d254f7-8c62-4061-ba7e-f358f1904ba5@oss.qualcomm.com>
References: <20260116-xiaomi-willow-v2-0-4694feb70cdb@mainlining.org>
 <20260116-xiaomi-willow-v2-2-4694feb70cdb@mainlining.org>
 <01d254f7-8c62-4061-ba7e-f358f1904ba5@oss.qualcomm.com>
Message-ID: <90a74369a2c4d9453de733a46fdd0ef1@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-01-21 13:45, Konrad Dybcio wrote:
> On 1/16/26 4:54 PM, Barnabás Czémán wrote:
>> The device was crashing on high memory load because the reserved 
>> memory
>> ranges was wrongly defined. Correct the ranges for avoid the crashes.
>> Change the ramoops memory range to match with the values from the 
>> recovery
>> to be able to get the results from the device.
>> 
>> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for 
>> xiaomi-ginkgo")
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
> 
> Have you verified this new and improved(tm) map e.g. by booting up
> the kernel with memtest=1 in cmdline?
I have verified with cat /dev/zero | tail | sleep 5
I can test with memtest=1 also
> 
> Konrad
