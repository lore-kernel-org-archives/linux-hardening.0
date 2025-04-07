Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C51FF1A9
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036444; cv=none; b=A5q4olLpAm8e5yJhS8GPuR5rq67a6CEyztfguWK9ZNu9yujed/X765W6gIM79oOJlvvgAET985Pe2NptxF6XJIqx8Nu6Wh2GTjCAIl6uy0rZLgyY6ewtrjSVb4A9okdyIG1U1ghm81Y2B7U/ScjxAxp9Ta18aJZXkjRYLV46Cng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036444; c=relaxed/simple;
	bh=lJjlQGtulUBgGzSAhb0/OF0vhURK+ETotepBl5yZ7ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR7wQ4sRpfDSCliFufCs434aZVwv0+TmrpsDFLjRN7dI6VOM4EdPss0+S+QqStz4c5icHLjuhDVG2YloJAz0Qy/Pb1iJKTD9BnkhERmxR/Ug7elhMge9i81UBfp+5aDFodOTyXFCxti4zu1mhJoGLmG6A452H6Kq5LLiDX5DlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hxmCrigZ; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hxmCrigZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=lJjlQGtulUBgGzSAhb0/OF0vhURK+ETotepBl5yZ7ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=hxmCrigZpjaNAUwQ7mmckRJjFfBe8T/NeBq0gvO8ahXK7CEGTT1jikiDRnUOri4AK
	 NXcwdg1N3zWHVV10I6ghSRHy13KePmDvOEeYEkOhxrNxOshOgJQ3cr1MjFK+UjnVt+
	 IG29b9BX8p6pnvFQxJ1+wXH9dVToq7HJIvPrVPlWWW2Fv+aX/mdJ020b5rCXhPj9Qr
	 JnZxHNW/mzK/Uj2JKjMlA2uaWc+32YGTqyanV2HC+eOXOxYZPlBoQEsRtaX0803nWT
	 1Q5CsLGuhTglSObyVvdKTf9fFc8o42XLTBzDLyYN0KsOD2CVxt29phQLfks0jv4vBZ
	 bjE2aOuEqixlg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id D2C482010642;
	Mon,  7 Apr 2025 14:33:58 +0000 (UTC)
Message-ID: <0e603b02-b272-4bcc-8b86-1a3dca9477d7@icloud.com>
Date: Mon, 7 Apr 2025 22:33:34 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, "Rob Herring (Arm)" <robh@kernel.org>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
 <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YxMjhCHd_GFYZyWYJU6wG7P5odoF8ais
X-Proofpoint-GUID: YxMjhCHd_GFYZyWYJU6wG7P5odoF8ais
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=585 mlxscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070103

On 2025/4/7 21:51, Andy Shevchenko wrote:
> First of all, this function is supposed to be run against constant string literals.

for strstarts(s, "prefix"), strlen("prefix") should *NOT* be compile
time constant. it is a loop and unavoidable to have strlen("prefix")
iterations.

> Second, this commit message has zero proofs to tell if there is actual performance
> downgrage even in the case when prefix is not a constant string literal.

for either constant string or non constant string. this patch
eliminating a loop which have strlen()iterations. i feel it is obvious
it can improve performance.


