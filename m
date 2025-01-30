Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9F20E6
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jan 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738195256; cv=none; b=L6ydiJ8TQZG9rLihHBSPArqW6GePmvHcEX2zAOq1pLrmKDiyQbxn05Lid6ckFSJUeS4Bje15kg3ymjEKkgvuLVLNRLYfX4+kPPlAir0v7Dt9okiDrdTTd197VvOsIui8XE0ANCXZq56+0iWw6now8v1L5KyXLhCllooogBwQyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738195256; c=relaxed/simple;
	bh=rmhEJBdAhw6QWgALtZAaFHAuvlmZ9phQrUbVP1Dwna8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed2704+Ty/2GqIYUqT0DIM8zhW9ZsNERoAkTxRJzTF0cvB6IiztqpmXUNbHfFi1kHefYIoPsLsoBEga7Vc234s7HeUaH3n9Cbl+V1cZutat1/e1Kpzgsoil5MnSNPI/v7uMZdfxy6/Pd2MfVZZ9QOtLl0G1Br2qrJuzsLBMbh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GgWJ7fEk; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GgWJ7fEk"
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id dC7StZzLGAfjwdHzEtDMn7; Thu, 30 Jan 2025 00:00:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id dHzCtmDapwoAOdHzCtULJD; Thu, 30 Jan 2025 00:00:47 +0000
X-Authority-Analysis: v=2.4 cv=UvVlNfwB c=1 sm=1 tr=0 ts=679ac12f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3GLQtCDrk5mhnYkuwPoHkA==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7T7KSl7uo7wA:10 a=07d9gI8wAAAA:8
 a=MSH2wtueLVmAUOx7J90A:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6l2UYJ7Tp33S5DDlVadMkoWryUzh14qbffLQOgOz8/Q=; b=GgWJ7fEkeCw5i/y11psWiaF5ci
	/c/U6KqIRyruQ/NiOzSg8VvnSPe47Vbmx4RXBSY56rJEsnhtAjKxyfs15+zOvyQRy1UkXPpfW7L16
	3eDiKKVppbafQ4NVWFJY5n+WaxTPPf+FI/irPI0FD8iRIkx8UB7uQU1D2OOei51ZkCV8yY7l+EhyZ
	Ckzn+9W40eu9/x/6/qXR34OwBpGiPEGdU3TpSoefGnQ+GOoV5S58bG3jqD+S81mhYJM1DHPbNBF+G
	ZZTpuN+DhxaY3/OD7oXekGkdK663PYdfYG+eVyUdCEk5Vd7l3sRyKig3RIgkmGmz8/vFGUnpTucqK
	jAwYzKaQ==;
Received: from [45.124.203.141] (port=55369 helo=[192.168.0.153])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tdHzA-0042mT-0G;
	Wed, 29 Jan 2025 18:00:44 -0600
Message-ID: <85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
Date: Thu, 30 Jan 2025 10:30:30 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
To: Halil Pasic <pasic@linux.ibm.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
 <20250129213826.291cfe12.pasic@linux.ibm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250129213826.291cfe12.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.141
X-Source-L: No
X-Exim-ID: 1tdHzA-0042mT-0G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.153]) [45.124.203.141]:55369
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI8j2ZiqRc94OCknS4VcY206nasAIYS9KsoBBBs2keVS1cZrQhwOSydWG+JO0CfGJEV/3nMaR6tSUvv3qFbFnP9RDgloCbLB5sO8KtIC203akPQmJsxp
 lyKm+3DQozk7YqEEp+LasHZ+HsFrPcbw90ntLy9lhRQmB1Inuitg7oFc+ZfPcg8b5SDv4sCgkMDoY0fI3SiteNIHsgwBqFGFnZxWEsz6+SVHSdrDMI19tOD0



On 30/01/25 07:08, Halil Pasic wrote:
> On Thu, 16 Jan 2025 14:18:59 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
>> Replace the deprecated one-element array with a modern flexible array
>> member in the struct ap_matrix_dev.
>>
> 
> I'm not sure I understand the value of this. What we have here is not
> a flexible array but a one element array. Something that in the generic
> case could be many but particularly for vfio-ap is always one.

You are correct. Only fake flexible arrays should be transformed into
C99 flex-array members [1].

Thanks
-Gustavo

[1] https://lwn.net/Articles/908817/
