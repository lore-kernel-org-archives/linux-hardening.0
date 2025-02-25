Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2F450FE
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448292; cv=none; b=tNCa50G1yOMKK7CSFSD2FRZs1o2hCqugLQq030oKyckPz6p998BxS1YZl5vfXWPQzVAjGc9bjPqSDxBSaRzlDFH9h+kz2t6DIG1lu0Nw42yeSWZ9C6cWsdIzPV+l3e32esp95y1T70yXZh5/UB+mZY0lrmBcVZ4l/NnpJ6N9Ils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448292; c=relaxed/simple;
	bh=kLCgPoctPehmp4UPhP9Ilyf4fSNulvovwDizoFjMJuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1q4J6Y8sb5UsW9ICqASy/1XWuYFqZ1pURhOgjQOcAVSPr5A70e9iWa+qBGtsXudfLTYDuAuj/iF8M+oeQxt0JzZMeZuhC7DsQV/Q6bixKAXTLJ4RocjCYnb0KL6g21mFldko4ZviUh6Mf1PIVnx9VEBp9w381Odt69ZnjGdHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=FAlNsKkU; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="FAlNsKkU"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id mbI9tZpmcMETlmk6WtohO2; Tue, 25 Feb 2025 01:51:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mk6VtEUCVrMXlmk6VtUReH; Tue, 25 Feb 2025 01:51:24 +0000
X-Authority-Analysis: v=2.4 cv=Xob8O0F9 c=1 sm=1 tr=0 ts=67bd221c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=oltRCMenW_0Ea9-Xwq4A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yt7FV8Is/XZOi8N7ebx2gw+ZNuxX/nMnNKn9hf0ikMI=; b=FAlNsKkUoIJYZiQd1fuXC5EcHn
	RvU4cr7cQwvw2jO60pbhr3XUqC8oJo4oagWZczJ4Mrhuytki65/XzuhYs+2iHsC2cap1CBRhRS44Z
	5pk5CO4hRWNavWIdLB5zKgkYJLXNgsNl3r/To1FSkpr+/+9kz+2GCniwZQRGRfmgkS+Y5SHFvphB3
	jO46v03XIDm9N5m9OVSij54DbuaANzHIIke9eiIdHKlRD7nnWxUj7HmWRFbcP4uANnaCdwqeLVqtT
	3NoR6ligc3UErUhqO8Pj2n+Cv4xSWKNMUg/2D67jE/w+NdVG+Oz590fxQkO2QcbqbvjZPzYi/aGUw
	spKgTMVw==;
Received: from [45.124.203.140] (port=53629 helo=[192.168.0.158])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tmk6U-001k4Y-2S;
	Mon, 24 Feb 2025 19:51:23 -0600
Message-ID: <c3c28d70-540b-4034-8a89-8a6c4dcf17ab@embeddedor.com>
Date: Tue, 25 Feb 2025 12:21:15 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8][next] nvme: target: Avoid
 -Wflex-array-member-not-at-end warnings
To: Christoph Hellwig <hch@lst.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1739957534.git.gustavoars@kernel.org>
 <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
 <20250224141938.GB1088@lst.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250224141938.GB1088@lst.de>
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
X-Exim-ID: 1tmk6U-001k4Y-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.158]) [45.124.203.140]:53629
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPTK0J0JlZiDrmQJyY349FgEuS6BAl4R6Pz7X0Md/wGNqas4rcme1sckN0hKfgYS7TfdVZgqw6Unj+6UpR8iAdqOOfeC3+DCwI4FSWCoE5zaA3Z6iHAu
 CX8gUvhIpKhkDO1F2jOZvy9YC8MA6aW6SREKDNb+ny4Nr9IcoLQ/UHPXGnuiM2zzxZ0q7P/IR+H2JIBK+aorsOLapPo2GimoZU6HP5QSzEfjSzZcDRljytB9



On 25/02/25 00:49, Christoph Hellwig wrote:
> On Mon, Feb 24, 2025 at 08:30:10PM +1030, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Change the type of the middle struct members currently causing trouble
>> from `struct bio` to `struct bio_hdr`.
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure `struct bio`, through which we can access the
>> flexible-array member in it, if necessary.
>>
>> With these changes fix 38 of the following warnings:
>>
>> drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
> 
> I'm not sure where you bio_hdr structure comes from, but maybe that's
> because you annoyingly split CC over the series, and by the number of
> patches probably also bundled unrelated changes.

Ugh, yes, I messed up my script just before creating the series.

> 
> In general our first resort here should be to move embedded bio to the
> of containing structures.  If that's not possible you'll need to explain
> why.
> 

Yes. Also, thanks for the feedback in your other response. I'll try to
follow that approach and see how it goes.

--
Gustavo
