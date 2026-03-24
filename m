Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025D38BF87
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389113; cv=none; b=lzNSHAxENaFes+Hn4C/0mZ1eYiQZ/5eFp4L3yN0qwmvLPO6R+Jwtwj+nCuKpSusV3quAGXbsKfDYohCL2Z6JIGjLMKYY3cDmbyGWTcPD6qOV9cA6rK3RpUI9t+uE0pKDR1fHKho+pddfxFEEz7JoHDxBfoFltlxzd/p9WSKisQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389113; c=relaxed/simple;
	bh=v8M/avmhZ+p5mDe6QYrKH2VFK1KNVhLl1fQvN6lgwqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmaTVjx0bp9VYVgeS5tfzrmuRXMpsLQ03kuh2eE5Zn3pIX0Y1UQPPJ/OfW+4BK4yJRbpqKqQUoCQwzQD5OSW6Jmg4bVLdvQDjK0LJgtfoTQq+ToSa8Q6396v/lqNpjReIr2grZltoqsqNoImTK0hInmOWoFonEMqHcPN76AGadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dren/ayx; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dren/ayx"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 531xwtN4oaPqL59fEwm5Zz; Tue, 24 Mar 2026 21:51:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 59eqwOoJyqfpW59eqw98JF; Tue, 24 Mar 2026 21:51:28 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=69c30777
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=knFFEZXCCS6sNPuXYSYA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t1tCrlPYFjY47Um8pkwyFOtPvnYcfZ5DeBcav9rYK4g=; b=dren/ayxdgB4upLGfffSGu8OXb
	JptHjxg8cZRkXf8xCWL30xw9K1nCDMgPhdy7hqMP+tH7S4GJRXzHvILOwsD2X2wcBhGOwaasrpnJg
	MEZWZGSnxDDNtXrFASoE3cTa5Dc9vFZs81Txr3HPIZ8teWCwBUU8nVL9bE0J8/ket7cqp1slV+T6j
	wkG2fgdsfpUnYQ+W2ene3HzHhNBKX6ID/BYmhso3z1qiSsJUnYeP87xc3VfmfBTHOB2Mxc9r4t3ZQ
	ME2deNHuTkwSFDBRSRF6/tuVWy31ko7Zj4lstxqYtq2jOY8nOQrTNYptBkVdjjuySVMWBC0GRg0qB
	HQMi0esg==;
Received: from [177.238.16.13] (port=54038 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w59ec-00000004L0s-42HP;
	Tue, 24 Mar 2026 16:51:15 -0500
Message-ID: <ad1df772-9fcc-4b53-b726-188d609b536c@embeddedor.com>
Date: Tue, 24 Mar 2026 15:50:05 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aaZr2A1UPJq33127@kspp>
 <30A4F6F9-9E41-4767-9949-8F89927CA159@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <30A4F6F9-9E41-4767-9949-8F89927CA159@kernel.org>
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
X-Exim-ID: 1w59ec-00000004L0s-42HP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:54038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKeLFx/qpz7NXPR3NxLuCj6mBBIv4ibGYA78B7nn0WGoEwh9BKSolUB8ObEuURuEux8Ar3lXHQuLMyYIw6G0nYRcCCnqIJG1d1CISqI7T6M8q/OE2Lw1
 kul7FDGu47GmCB/zo2DIHIMXU8im8OKuVEwPvq5cQUo0tRDMuEf0V7hIkJ45f4G68lpmK6cCUPbnq21h8qCkO7EMd5+ZaNf3pgK1NUpuLefruxGNJJDjJIPg



On 3/4/26 01:30, Kees Cook wrote:
> 
> 
> On March 2, 2026 9:04:24 PM PST, "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> struct bpf_prog_array is a flexible structure, this is a structure that
>> contains a flexible-array member (struct bpf_prog_array_item items[];).
>>
>> We create the new struct bpf_prog_array_hdr type, and use it to replace
>> the object type causing trouble in struct bpf_empty_prog_array, namely
>> struct bpf_prog_array hdr;
>>
>> Also, once -fms-extensions is enabled, we can use transparent struct
> 
> Typo: "since" instead of "once".

Ah yes, thanks!

> 
>> members in struct bpf_prog_array.
>>
>> Notice that the newly created type does not contain the flex-array
>> member `items`, which is the object causing the -Wfamnae warnings
>> in struct bpf_empty_prog_array.
>>
>> With these changes, fix the following warnings:
>>     
>> 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> include/linux/bpf-cgroup.h | 2 +-
>> include/linux/bpf.h        | 8 ++++++--
>> kernel/bpf/core.c          | 6 +++---
>> 3 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 2f535331f926..e7d266600ac7 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>> 	struct bpf_prog_array *array;
>>
>> 	array = rcu_access_pointer(cgrp->bpf.effective[type]);
>> -	return array != &bpf_empty_prog_array.hdr;
>> +	return (void *)array != (void *)&bpf_empty_prog_array.hdr;
>> }
>>
>> /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 05b34a6355b0..488de065466e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2360,13 +2360,17 @@ struct bpf_prog_array_item {
>> 	};
>> };
>>
>> -struct bpf_prog_array {
>> +struct bpf_prog_array_hdr {
>> 	struct rcu_head rcu;
>> +};
>> +
>> +struct bpf_prog_array {
>> +	struct bpf_prog_array_hdr;
>> 	struct bpf_prog_array_item items[];
>> };
>>
>> struct bpf_empty_prog_array {
>> -	struct bpf_prog_array hdr;
>> +	struct bpf_prog_array_hdr hdr;
>> 	struct bpf_prog *null_prog;
>> };
> 
> AFAICT, this struct exists entirely to populate a single element of "items" in a global variable. (I only see "null_prog" used during the initializer.) None of this is needed; globals will be correctly sized with an array initializer of a FAM. Totally untested:
> 
> struct bpf_prog_array bpf_empty_prog_array = {
>      .items = { NULL, },
> };

Okay, in this case the patch would look as follows:

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2f535331f926..b2e79c2b41d5 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
  	struct bpf_prog_array *array;

  	array = rcu_access_pointer(cgrp->bpf.effective[type]);
-	return array != &bpf_empty_prog_array.hdr;
+	return array != &bpf_empty_prog_array;
  }

  /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..4f5b9e85a20c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2365,18 +2365,13 @@ struct bpf_prog_array {
  	struct bpf_prog_array_item items[];
  };

-struct bpf_empty_prog_array {
-	struct bpf_prog_array hdr;
-	struct bpf_prog *null_prog;
-};
-
  /* to avoid allocating empty bpf_prog_array for cgroups that
   * don't have bpf program attached use one global 'bpf_empty_prog_array'
   * It will not be modified the caller of bpf_prog_array_alloc()
   * (since caller requested prog_cnt == 0)
   * that pointer should be 'freed' by bpf_prog_array_free()
   */
-extern struct bpf_empty_prog_array bpf_empty_prog_array;
+extern struct bpf_prog_array bpf_empty_prog_array;

  struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
  void bpf_prog_array_free(struct bpf_prog_array *progs);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 67eb12b637a5..ca39d2e690b9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2613,8 +2613,10 @@ static struct bpf_prog_dummy {
  	},
  };

-struct bpf_empty_prog_array bpf_empty_prog_array = {
-	.null_prog = NULL,
+struct bpf_prog_array bpf_empty_prog_array = {
+	.items = {
+		{ .prog = NULL },
+	},
  };
  EXPORT_SYMBOL(bpf_empty_prog_array);

@@ -2625,14 +2627,14 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
  	if (prog_cnt)
  		p = kzalloc_flex(*p, items, prog_cnt + 1, flags);
  	else
-		p = &bpf_empty_prog_array.hdr;
+		p = &bpf_empty_prog_array;

  	return p;
  }

  void bpf_prog_array_free(struct bpf_prog_array *progs)
  {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || progs == &bpf_empty_prog_array)
  		return;
  	kfree_rcu(progs, rcu);
  }
@@ -2653,7 +2655,7 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)

  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
  {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || progs == &bpf_empty_prog_array)
  		return;
  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
  }

Could maintainers give us feedback or comment on this, please? :)

Thanks!
-Gustavo
