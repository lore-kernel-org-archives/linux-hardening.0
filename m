Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59229207DEF
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292369; cv=none; b=FfrZ3iCXPIlBBwpyAPm8iN/r9WVYwomcPgC43J2GyTNNEr8+X+OvY6X5KLsM832HO6vYtKCHcjjUWntsYcYKt3r+yubsRiFUuXsJTkFQpfAvJ4zrnTAOvk8IZtHGqxr0sD+rCNLpz5jD+Cj14arKnLL+yBpcAzrTo/HKctnHL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292369; c=relaxed/simple;
	bh=Gksz8n73qohPifNidA/j+8NeAwn11kMEZLhd2wCfNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvHwLe6GnO3WmusAfTemMmJzp5lTwpafA19FWGL4SYRxno/7Uc8Dwt8xcVg/3rF1CC/ZyhwZlREW6r5Qymh9um3Xz5wM9O90KU1jfUMcSFDF4SILsf0LWUUC7Rryr6NiCSOGPP70iU0zptmYdfVOU8yJRvfzugtcEep9scXbvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yXOnxjCG; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yXOnxjCG"
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id uKFptkhgDAfjwuTpdtLjij; Tue, 18 Mar 2025 10:05:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id uTpctJpztRxIGuTpctbfyN; Tue, 18 Mar 2025 10:05:56 +0000
X-Authority-Analysis: v=2.4 cv=N/viFH9B c=1 sm=1 tr=0 ts=67d94584
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=P-IC7800AAAA:8
 a=dXSzBa_xCpuFaA4JCisA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gksz8n73qohPifNidA/j+8NeAwn11kMEZLhd2wCfNk4=; b=yXOnxjCG4dFVz00IHE7akjgzjP
	5DhTszJmnW3JRh5JwjLl441qeW6p/+QAwmfV/B8kG0ZsOqHa6XQKwfYvyx6gGty1slER6W+2Cs70V
	elGeiCNQnzGz2OCoK/4fC/qND4d3eovT0DswdI41aCVTSPFDiaClcHsWbIkP/lVYRLQ+jp0xBpxPc
	pATqaTXE5wMdldgxJr+C5ureATGuKl6h6t2Z85MPQ6f/hhX9SlkoU22LiyVc/FciAa2X3PTZ+kKDl
	baoMp14Dl24GmiJuBaKl6CDSYPYrFuXfWHXbSsTf/4DIwq57fZzaoWCr1ZoQ3utcAIYESiJZ0tEJV
	abQsMHhg==;
Received: from [45.124.203.140] (port=52741 helo=[192.168.0.160])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tuTpZ-00000002SJ5-3F1z;
	Tue, 18 Mar 2025 05:05:54 -0500
Message-ID: <3f899c06-1f6d-4039-aeed-88767f9e23c4@embeddedor.com>
Date: Tue, 18 Mar 2025 20:35:52 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
To: Kees Cook <kees@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z9dy43vUUh4goi-Q@kspp> <Z9d7rp-ullvmXKoM@google.com>
 <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
 <20250317120447.4fa26083@jic23-huawei> <Z9jRtoDZM0opi_4C@google.com>
 <5524C796-6426-4A32-962E-AB4B4E3DC4A7@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5524C796-6426-4A32-962E-AB4B4E3DC4A7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tuTpZ-00000002SJ5-3F1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.160]) [45.124.203.140]:52741
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL+SCd6oZeDy+xd4oaDhqqgNtEP1Cri/RFhCWidZI4nTD/rhhJjN9egBY4yUbC8AJgrFtkDh+5Dy51azP5muR2RYGcjCSWpX4gu9DwCK3cSRIx0hJ5cg
 EpEB3XYXGIg+gVd3LKctCl5tzCPMex3CDzz1tGjHkAtYRuWlLJiU+/h5U9eKDIlAPdrp1fu5fcrqSIA3GmmiFompa0lx8C8HuhvWyY3qBU8UPYi3d81kTM3/


> Did MAX() not work? I would expect it to do compile time comparison of two sizeof()s. It can do other arithmetic no problem, e.g.:
> https://elixir.bootlin.com/linux/v6.13.7/source/lib/vsprintf.c#L1097

Yep, that does the trick. :)

Thanks
--
Gustavo

