Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B6281504
	for <linux-hardening@vger.kernel.org>; Wed,  3 Dec 2025 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764738755; cv=none; b=i8OBue5m56XE/ynAdGo+F6zPKml24sBeJ4BeVK+huqFmPJKsIQTq30cEiOP85OgeyBldrJedYtYwgmAgJ9/g2ZGAHLt5a0r42brNMV4y5+204Eo7fcGfHVmJ0eoWQq5uCLg8Bokym/gJhafoCpixiHzqaG2RsEgRb956mjL5ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764738755; c=relaxed/simple;
	bh=cW07RvX8A2KPX3wtJ7XOqY5EO3LW/7VmvQ/tLUqcbvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcuWjJ07Aj6t733hRDkDr44PsAze7q5z4C7jFVA4Vc+OhJw/xpoa3JdWgdOLY4mokmTmAEOqxXkuQ9ISKL/BEeQ6pNhkDAUo/MiFPY1R1Xj+pRzvwRv0PQ6cZglnFkX6Emtluqfq0qVdIclWyoW/L4otxzNw2c6kEGBMcBrJWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hivpQeg6; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hivpQeg6"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id QXBav69MrSkcfQfAGv9Qn0; Wed, 03 Dec 2025 05:12:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id QfAGvVuSoh8QWQfAGv1vpO; Wed, 03 Dec 2025 05:12:32 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=692fc6c0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=5TVvHJhSY-PbQlZ89gMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0koUy0HQ2Rv1Yb0+8qx3+2fqlAkYI73um7tplClDJDg=; b=hivpQeg6IQ9gufzK/kOaE/afSz
	U75evQh9mhDmmJWaeO5QMLm9cFr3tbkezE7rt/mX4HOXhbImdGJOGLadq3WmGpW2bNDojgZiwFGHO
	gmf4RvdP4Kj0Yh1subwBM8ZBXE9XeGcDibM6yNVYc1lVvd2kTlujS5tfLrBO8/0OZz/jZBsiCF915
	PDw5z9Gat9S7SNaG27F4550mMBjJYDzljfUc+649kqoPyh2M7Ov8Wa+lub2mTi/wPc6n7KVbV1957
	BShfAY7+k7+bnhjflOyy0mrkLqdL9IIcgey3wYUAJtUCEN7rSfW8JOywTZvudu882XztHMlBDXQuD
	bSzCqWxA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:62867 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vQfAF-00000001d8m-2CCb;
	Tue, 02 Dec 2025 23:12:31 -0600
Message-ID: <918e665c-fb1a-430f-bb1c-b73ce2d67348@embeddedor.com>
Date: Wed, 3 Dec 2025 14:12:27 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ocfs2: Avoid -Wflex-array-member-not-at-end warning
To: Heming Zhao <heming.zhao@suse.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKm_7aN7Smc3J5L@kspp>
 <7vsq3tvjuv3ppiot3lgithyp76r4jbbssoiiuni6zvj5pajsov@nketwax66jss>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7vsq3tvjuv3ppiot3lgithyp76r4jbbssoiiuni6zvj5pajsov@nketwax66jss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vQfAF-00000001d8m-2CCb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:62867
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL2vMd2d9HpmEdeFVXfwSmkMIOFng5v78CDjs9lsMVrR6fFrtqVllrYgpVBXgNShgTAhimmmt9A5xft5Q7xbPLqzo1J7rdnc6wIT4zDHErWGUodVV/ii
 llpD4IVT8UMwrBFXSDVuvdy7Jih02izn0bBlt5wIu7+mXgUYSIH3srC84MVs3BGbPyCPUc0vqX6ugR3UhppoLHX9h/x14fxXmv73FcQnbYTYt4XJlAc/NAsu

Hi all,

Friendly ping: who can take this, please? 🙂

Thanks!
-Gustavo

On 11/17/25 14:32, Heming Zhao wrote:
> On Tue, Nov 11, 2025 at 12:01:19PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>
>> fs/ocfs2/xattr.c:52:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM) and a
>> set of MEMBERS that would otherwise follow it.
>>
>> This overlays the trailing MEMBER struct ocfs2_extent_rec er; onto the
>> FAM struct ocfs2_xattr_value_root::xr_list.l_recs[], while keeping the
>> FAM and the start of MEMBER aligned.
>>
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after the related structure --no
>> blank line in between.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> LGTM.
> Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> 
>> ---
>>   fs/ocfs2/xattr.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>> index d70a20d29e3e..09069defd7e1 100644
>> --- a/fs/ocfs2/xattr.c
>> +++ b/fs/ocfs2/xattr.c
>> @@ -49,9 +49,13 @@
>>   #include "ocfs2_trace.h"
>>   
>>   struct ocfs2_xattr_def_value_root {
>> -	struct ocfs2_xattr_value_root	xv;
>> -	struct ocfs2_extent_rec		er;
>> +	/* Must be last as it ends in a flexible-array member. */
>> +	TRAILING_OVERLAP(struct ocfs2_xattr_value_root, xv, xr_list.l_recs,
>> +		struct ocfs2_extent_rec		er;
>> +	);
>>   };
>> +static_assert(offsetof(struct ocfs2_xattr_def_value_root, xv.xr_list.l_recs) ==
>> +	      offsetof(struct ocfs2_xattr_def_value_root, er));
>>   
>>   struct ocfs2_xattr_bucket {
>>   	/* The inode these xattrs are associated with */
>> -- 
>> 2.43.0
>>
>>
> 

