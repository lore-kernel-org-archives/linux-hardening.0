Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37C4035AD
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971024; cv=none; b=pxjVAf5fVgO/v/i/DT8q1dJLfvzGWSIPhRFxMyaI5wB7ZApCi3C5IvGpAVUCno2KlFrWq1dU4UljBumNUbpRj3P1GZ2G2mJC9FPTDCx0Dwj0qYiVjpXfxYyuvB0NKIq8HDsMT+/OqhAzcoCWw5MTyXp5KxoTR3dQvOba7y69RHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971024; c=relaxed/simple;
	bh=TxM4jHBdwMd3cEwpdnxl7GgzLf90cA7gi3yegKc723w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3IwaTzNsTHSLjIeteCQ31xBUhsrm2ezq9UexFkCcV3wM8n2pp4Xc1uLZBnOgR5+kKgz6NkhoMVEL1PzVKy3ZC4ZxlLPcY3/KNsq41uCXtyPMKQfdfeM0BeC0deDqHaCQBNUsqQXWlK2LBYwPsT2DXWxFxLg45DmSI+70e9FHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=G0QFnCez; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="G0QFnCez"
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id 7YwhwahB7c7NE7b1EwM7bi; Tue, 31 Mar 2026 15:28:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b1CwFRdqwWe67b1CwoMrV; Tue, 31 Mar 2026 15:28:38 +0000
X-Authority-Analysis: v=2.4 cv=RfSQC0tv c=1 sm=1 tr=0 ts=69cbe827
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=WdX8k5g-n6Z53etAVCAA:9
 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jpxx80URzNBRSO9M4kIAxiBfPa78VaoakULnXtYzC9w=; b=G0QFnCezdj9n0kysZVYl8kce9J
	9vNVvW0DmKzLhMS455wQAVBM4DiRJ9Ar7Br+XUviTwI1SaDfZbEvlq8Pk5s3nHTpqyuv27Nuqjbba
	/wKv+nxnXC/oemXF/FASe8OEDTcCYro9PnrVUQ7vW3S5DQugDhmRupj6d4LdQgZI2U3FeHLsawPj7
	DUDCt1isfXUnEyM4dFzmeinS5YDAJK7kX2CmCKSk6mq5NSgDOR0skoU+KJhS1CQ/psIEyyJFecxpY
	ewTZnq61Pfkklc4U87G8wLffSXmzgH81gA7mafcIInLrW8L7v0jP0ko9RLWJs99wrkRF9FON3Zvh4
	URtCK7qg==;
Received: from [177.238.16.13] (port=60002 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b19-00000002CdC-0QPD;
	Tue, 31 Mar 2026 10:28:35 -0500
Message-ID: <f5ae767c-8d4a-424d-b11a-d2a54127895c@embeddedor.com>
Date: Tue, 31 Mar 2026 09:27:24 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] clk: kirkwood: use kzalloc_flex
To: Brian Masney <bmasney@redhat.com>, Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..."
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260330205504.10143-1-rosenp@gmail.com>
 <acvUoSOOF_9UQC75@redhat.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <acvUoSOOF_9UQC75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7b19-00000002CdC-0QPD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:60002
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfABrV0ClV/B2NGQAOQQwbMU1tfE0afax8+p9rN1/P73Hn8i6xIvRMT7KQhF13ddQuHj68e1RmVptIQNAGUF980pC6cMVeeehCk2DarEXyUb9j+JnYdJJ
 cDQYzjgasoV3O2bE/O5iS5NSrvFZd0+52RVi03VKCB8vdzF10pp84qjukZlDcMy7YMnboZn27TEL9ujWJ6gtz3eOVUoe424qhHDBAZm3qHmR2KyjaOQQ8QCk



On 3/31/26 08:05, Brian Masney wrote:
> On Mon, Mar 30, 2026 at 01:55:04PM -0700, Rosen Penev wrote:
>> Simplify allocation by using a flexible array member and kzalloc_flex to
>> combine allocations.
>>
>> Add __counted_by for extra runtime analysis. Move counting variable
>> assignment to right after allocation as required by __counted_by.

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   v2: remove unused goto.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> 
> For the future, if someone asks for changes in a previous version, then
> be sure to CC them on the next revision.
> 

