Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F93009C1
	for <linux-hardening@vger.kernel.org>; Tue,  6 Jan 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682537; cv=none; b=Px4bzKUO+2k6zRZmxc7ukcdd7txYRYFRPjVuw14BNkfVkRMqrvmHO+zBexb1oblLRL2WkRHtPXkfr2jnbRdE3tnrVkQEzr3+myJq8L1WocKlrMDN4nj+6qb7G5fYDT1ohLXuAityvJLftHWsu4TwC3XrA3MqC7g4haDVcs3n+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682537; c=relaxed/simple;
	bh=ujjuPqYl39O51N9nKa7JvPk5vIzxNM+20Uw4oY+Agl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/OfWPcZt6wn5nfot3VPJo8bkALYeoQnZUZsNrn+jiO437JQGA+GAoTi6+2InkhrWouc/jVFn7WSejqh9FPaHfaEFsRgpKkGUzDT//W1LEFY1TCf726Bd39Rb8I8ctj19svk0QZpUWMQebPXkzp3Fg4hycUBgHlQvHjyb7HJjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=G/vez5mI; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="G/vez5mI"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id d06tvey9dipkCd0x6v2eJi; Tue, 06 Jan 2026 06:54:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id d0x5vG8rIjAxud0x5vTgwB; Tue, 06 Jan 2026 06:53:59 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=695cb187
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Aea70ojWhvW6xI+oM0giEQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=fgAqcRqT0STgUfz1giMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MCst0vXTrl54MA5QK689mpZvQYuCeJQ5rEPbETOOHlY=; b=G/vez5mIJoapC1BKyFfPstgQf/
	yfFBDEawZrWjFtrTRNPEHqqUYrjgMg563y1RjKy3rofPcvBGYieRFV65EvDyvpkaM1BLqOXQ4b6J9
	y9Sc5uWkYWr/zOarUe5e8v3Pati9zuNbHpxvg5IrYBEDNNjSqWVtljju5sn+hGpBXCZ3quwTyLqq2
	yUAD9Ma4Rgb3/45VPmt0YxaOauUpBYyUjFSZkiqrymsHgZpi7qvyWnjVCTd8HNdZpcE2W5MmSCrSD
	kvIpLc8/1eS3djEQ0Jh+mOk/WDosBov94Sc9SL75BQPoZ1FUGoJo5s9J3OEP+hD0MCamd1XrEeZZ5
	1qleFl5A==;
Received: from flh4-122-130-137-161.osk.mesh.ad.jp ([122.130.137.161]:55764 helo=[10.221.196.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vd0x4-00000003kxS-1fbV;
	Tue, 06 Jan 2026 00:53:59 -0600
Message-ID: <8ac82e29-b193-4484-9bf4-19988d0141d6@embeddedor.com>
Date: Tue, 6 Jan 2026 15:53:50 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
 <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
 <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
 <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 122.130.137.161
X-Source-L: No
X-Exim-ID: 1vd0x4-00000003kxS-1fbV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-122-130-137-161.osk.mesh.ad.jp ([10.221.196.44]) [122.130.137.161]:55764
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKthT7HDsJXoQ0IVK7GsTZFzM44KEhtvGkeVoQkIDWkKFTHVp6su+alibz1RSCkjtGjvePtWna9w/GHCIQllc4lXEIMQLH0CL5iF8KN++Uvwuug9sIIF
 itzP27kzlMD3BTQNLEn0tx6W228rQAGkQRpoCdaoTcl7tGiPwtbFKi5BM4x3GM01H784G+fg9yk4OpGLAzYt9J9B5BCjvfZd9MFIdpQZsxa4LebcyfLb4MQy



On 12/19/25 01:32, Michal Koutný wrote:
> On Thu, Dec 18, 2025 at 06:09:42AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
>>> Note that this level may already be used in existing BPF programs (e.g.,
>>> tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consider compatibility here?
>>
>> That's a good point.
> 
> I wouldn't be concerned about this particular aspect. The commit
> e6ac2450d6dee ("bpf: Support bpf program calling kernel function")
> excludes ABIs, the example program uses ksyms (not kfuncs), so there
> could even apply Documentation/process/stable-api-nonsense.rst.
> OTOH, the semantics of level is unchanged for BPF helpers (that are the
> official API).
> 
> 
>> Is __counted_by instrumentation tied to some compiler flag? If so,
>> might as well make it an optional extra field specifically for the
>> annotation rather than changing the meaning of an existing field.
> 
> Honestly, I can see benefit mainly in the first patch of the series
> (posted the rest for discussion).
> 
> I'd like to ask Gustavo whether __counted_by here buys us anything or
> whether it's more useful in other parts of kernel (e.g. flexible
> allocations in networking code with outer sources of data).

Ideally, all structures containing a flexible-array member (FAM) should
be annotated. However, if this is too much of a hassle right now, I'd
say the priority is to avoid the -Wflex-array-member-not-at-end warnings,
first.

Thanks
-Gustavo

